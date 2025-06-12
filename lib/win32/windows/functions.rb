require "ffi" unless defined?(FFI)

module Windows
  module Functions
    module FFI::Library
      def attach_pfunc(*args)
        attach_function(*args)
        private args[0]
      end
    end

    extend FFI::Library

    ffi_lib :kernel32

    typedef :ulong, :dword
    typedef :uintptr_t, :handle
    typedef :pointer, :ptr
    typedef :string, :str

    attach_pfunc :CloseHandle, [:handle], :bool

    attach_pfunc :CreateFile, :CreateFileA,
      %i{str dword dword pointer dword dword handle},
      :handle

    attach_pfunc :CreateFileMapping, :CreateFileMappingA,
      %i{handle pointer dword dword dword str},
      :handle

    attach_pfunc :CreateSemaphore, :CreateSemaphoreA,
      %i{pointer long long str},
      :handle

    attach_pfunc :FlushViewOfFile, %i{uintptr_t size_t}, :bool

    attach_pfunc :MapViewOfFileEx,
      %i{handle dword dword dword size_t uintptr_t},
      :uintptr_t

    attach_pfunc :OpenFileMapping, :OpenFileMappingA,
      %i{dword bool str},
      :handle

    attach_pfunc :ReleaseSemaphore, %i{handle long pointer}, :bool
    attach_pfunc :UnmapViewOfFile, [:uintptr_t], :bool
    attach_pfunc :WaitForSingleObject, %i{handle dword}, :dword
    attach_pfunc :VirtualQuery, %i{uintptr_t pointer size_t}, :size_t
  end
end
