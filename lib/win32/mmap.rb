require_relative 'windows/constants'
require_relative 'windows/structs'
require_relative 'windows/functions'

# The Win32 module serves as a namespace only.
#
module Win32
  # The MMap class encapsulates functions for memory mapped files.
  #
  class MMap
    # The version of the win32-mmap library.
    VERSION = '0.4.2'

    include Windows::Constants
    include Windows::Functions
    include Windows::Structs

    # The name of the file from which to create a mapping object.  This
    # value may be nil.
    #
    attr_accessor :file

    # The protection for the file view.  This may be any of the following
    # values:
    #
    # * PAGE_READONLY
    # * PAGE_READWRITE
    # * PAGE_WRITECOPY
    # * PAGE_WRITECOPY
    # * PAGE_EXECUTE_READ
    # * PAGE_EXECUTE_READWRITE
    #
    # You can OR the protection value with any of these section attributes:
    #
    # * SEC_COMMIT
    # * SEC_IMAGE
    # * SEC_LARGE_PAGES
    # * SEC_NOCACHE
    # * SEC_RESERVE
    #
    # The default protection is PAGE_READWRITE.
    #
    attr_accessor :protection

    # A string that determines the name of the mapping object.
    # By default this value is nil, i.e. anonymous.  If you specify a +name+
    # that already exists then an attempt is made to access that object.
    #
    attr_accessor :name

    # The maximum size for the file mapping object.  If a +file+ is
    # specified, this value defaults to the size of +file+. Otherwise
    # it defaults to zero (though you should set it manually).
    #
    attr_accessor :size

    # Access desired to the file mapping object.  This may be
    # any of the following values:
    #
    # * FILE_MAP_WRITE
    # * FILE_MAP_READ
    # * FILE_MAP_COPY
    # * FILE_MAP_ALL_ACCESS
    #
    # The default access is FILE_MAP_WRITE.
    #
    attr_accessor :access

    # The address of the file view mapping.
    #
    attr_reader :address

    # Suggested starting address of mapped view.  If this value is not
    # specified, the system will choose the base mapping address.  If you do
    # specify a value, it must be a multiple of the system's allocation
    # granularity.
    #
    # Note: The MSDN documentation recommends that, in most case cases, you
    # should not set this value.
    #--
    # A system's allocation granularity can be found via GetSystemInfo()
    # and the dwAllocationGranularity member of the SYSTEM_INFO struct.
    #
    attr_accessor :base_address

    # Sets whether or not a semaphore lock is automatically placed on the
    # mapped view for read and write operations.  This is true by default.
    #
    attr_writer :autolock

    # The value, in milliseconds, used to wait on the semaphore lock.  Only
    # used if the +autolock+ option is true. The default is 10 milliseconds.
    #
    attr_accessor :timeout

    # :call-seq:
    #     MMap.new(opts = {})
    #     MMap.new(opts = {}){ |address| block }
    #
    # Creates and returns a new Win32::MMap object.  If +file+ is set, then
    # that file is used to create the mapping.  If a block is provided the
    # address is yielded and the mapping object is automatically closed at the
    # end of the block.
    #
    # Accepts any one of the following hash attributes:
    #
    # * protection
    # * size
    # * access
    # * inherit
    # * name
    # * base_address
    # * autolock
    # * timeout
    # * file
    #
    # Please see the documentation on the individual attributes for
    # further details.  Note that, although these are accessors, they
    # *must* be set in the constructor (if set at all).  Setting them
    # after the call to MMap.new will not have any effect.
    #
    # == Example
    #    require 'win32/mmap'
    #    require 'windows/msvcrt/string'
    #    include Windows::MSVCRT::String
    #    include Win32
    #
    #    # Reverse the contents of a file.
    #    mmap = MMap.new(:file => 'test.txt') do |addr|
    #       strrev(addr)
    #    end
    #
    def initialize(opts = {})
      valid = %w[
        file name protection access inherit size
        base_address open autolock timeout
      ]

      @open     = nil
      @file     = nil
      @autolock = nil

      # Validate the keys, handle inherit specially.
      opts.each{ |key, value|
        key = key.to_s.downcase

        unless valid.include?(key)
          raise ArgumentError, "Invalid key '#{key}'"
        end

        if key == 'inherit'
          self.inherit = value # To force inherit= method call
        else
          instance_variable_set("@#{key}", value)
        end
      }

      @protection   ||= PAGE_READWRITE
      @access       ||= FILE_MAP_WRITE
      @size         ||= 0
      @inherit      ||= nil
      @base_address ||= 0
      @timeout      ||= 10 # Milliseconds

      self.inherit = false unless @inherit

      @hash = {}

      # Anything except an explicit false means the autolock is on.
      @autolock = true unless @autolock == false

      @lock_flag = 0 # Internal use only

      if @file
        if File.exists?(@file)
          fsize = File.size(@file)
          raise ArgumentError, 'cannot open 0 byte file' if fsize.zero?
          @size = fsize if @size < fsize
        end

        rights = GENERIC_READ|GENERIC_WRITE

        @fh = CreateFile(@file, rights, 0, nil, OPEN_ALWAYS, 0, 0)

        if @fh == INVALID_HANDLE_VALUE
          raise SystemCallError.new('CreateFile', FFI.errno)
        end
      else
        @fh = INVALID_HANDLE_VALUE
      end

      if @open
        @mh = OpenFileMapping(@access, @inherit[:bInheritHandle], @name)
        raise SystemCallError.new('OpenFileMapping', FFI.errno) if @mh == 0
      else
        @mh = CreateFileMapping(@fh, @inherit, @protection, 0, @size, @name)
        raise SystemCallError.new('CreateFileMapping', FFI.errno) if @mh == 0
      end

      if @open
        @address = MapViewOfFileEx(@mh, @access, 0, 0, 0, @base_address)
        @size    = get_view_size()
      else
        @address = MapViewOfFileEx(@mh, @access, 0, 0, 0, @base_address)
      end

      if @address == 0
        raise SystemCallError.new('MapviewOfFileEx', FFI.errno)
      end

      if @autolock
        @semaphore = CreateSemaphore(nil, 1, 1, "#{@name}.ruby_lock")
        if @semaphore == 0
          raise Error, get_last_error
        end
      end

      if block_given?
        begin
          yield @address
        ensure
         close
        end
      end

      @address
    end

    # Opens an existing file mapping using +name+.  You may pass a hash
    # of +opts+ as you would to MMap.new.  If you don't specify a size
    # as part of the +opts+, it will be dynamically determined for you
    # (in blocks equal to your system's page size, typically 4k).
    #
    # This method is otherwise identical to MMap.new.
    #--
    # This forces MMap.new to use OpenFileMapping() behind the scenes.
    #
    def self.open(name, opts={}, &block)
      opts[:name] = name
      opts[:open] = true
      self.new(opts, &block)
    end

    # Sets whether or not the mapping handle can be inherited
    # by child processes.
    #--
    # If true, we have to create a SECURITY_ATTRIBUTES struct and set
    # its nLength member to 12 and its bInheritHandle member to TRUE.
    #
    def inherit=(bool)
      @inherit = SECURITY_ATTRIBUTES.new
      @inherit[:nLength] = SECURITY_ATTRIBUTES.size

      if bool
        @inherit[:bInheritHandle] = true
      else
        @inherit[:bInheritHandle] = false
      end
    end

    # Returns whether or not the mapping handle can be
    # inherited by child processes.  The default is false.
    #
    def inherit?
      @inherit and @inherit[:bInheritHandle]
    end

    # Writes +num_bytes+ to the disk within a mapped view of a file, or to
    # the end of the mapping if +num_bytes+ is not specified.
    #
    def flush(num_bytes = 0)
      unless FlushViewOfFile(@address, num_bytes)
        SystemCallError.new('FlushViewOfFile', FFI.errno)
      end
    end

    # Unmaps the file view and closes all open file handles.  You should
    # always call this when you are finished with the object (when using
    # the non-block form).
    #
    def close
      UnmapViewOfFile(@address) if @address
      CloseHandle(@fh) if @fh
      CloseHandle(@mh) if @mh
      ReleaseSemaphore(@semaphore, 1, nil) if @semaphore
    end

    # Returns whether or not a semaphore lock is automatically placed on the
    # mapped view for read and write operations.  This is true by default.
    #
    def autolock?
      @autolock
    end

    # Writes a string directly to the underlying file
    def write_string(content)
      lock_pattern do
        ptr = FFI::Pointer.new(:char, @address)
        ptr.write_string(content,content.length)
      end
    end

    # Reads a string of a given length from the beginning of the file
    # if no length is given, reads the file with the @size attribute
    # of this instance
    def read_string(length = @size)
      lock_pattern do
        FFI::MemoryPointer.new(:char, length)
        ptr = FFI::Pointer.new(:char, @address)
        ptr.read_string(length)
      end
    end

    private

    # :stopdoc:

    # This is used to allow dynamic getters and setters between memory
    # mapped objects.
    #--
    # This replaces the getvar/setvar API from 0.1.0.
    #
    def method_missing(method_id, *args)
      method = method_id.id2name
      args = args.first if args.length == 1

      if method[-1,1] == '=' # Setter
        method.chop!
        @hash["#{method}"] = args

        lock_pattern do
          instance_variable_set("@#{method}", args)
          marshal = Marshal.dump(@hash)
          ptr = FFI::Pointer.new(:char, @address)
          ptr.write_string(marshal,marshal.length)
        end

      else # Getter

        lock_pattern do
          buf = FFI::MemoryPointer.new(:char, @size)
          ptr = FFI::Pointer.new(:char, @address)
          buf = ptr.read_string(@size)
          hash = Marshal.load(buf)
          val  = hash["#{method}"]
          instance_variable_set("@#{method}", val)
        end

        return instance_variable_get("@#{method}")
      end
    end

    def lock_pattern
      if @autolock
        if mmap_lock
          output = yield
          mmap_unlock
          output
        end
      else
         output = yield
         output
      end
    end

    # Adds a semaphore lock the mapping.  Only used if +autolock+ is set
    # to true in the constructor.
    #
    def mmap_lock
      bool = false

      if(@lock_flag == 0)
        if WaitForSingleObject(@semaphore, @timeout) == WAIT_OBJECT_0
          bool = true
        end
      end

      @lock_flag += 1
      bool
    end

    # Releases a semaphore lock on the view.  Only used if +autolock+ is
    # set to true in the constructor.
    #
    def mmap_unlock
      @lock_flag -= 1

      return false if @lock_flag != 0

      if ReleaseSemaphore(@semaphore, 1, nil) == 0
        raise SystemCallError.new('ReleaseSemaphore', FFI.errno)
      end

      true
    end

    # Gets the size of an existing mapping based on the address. This
    # is used by the MMap.open method when a size isn't specified.
    #
    def get_view_size
      mbi = MEMORY_BASIC_INFORMATION.new
      VirtualQuery(@address, mbi, mbi.size)
      mbi[:RegionSize]
    end
  end # MMap
end # Win32
