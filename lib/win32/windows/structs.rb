require 'ffi'

module Windows
  module Structs
    extend FFI::Library
    typedef :ulong, :dword

    class SECURITY_ATTRIBUTES < FFI::Struct
      layout(
        :nLength, :dword,
        :lpSecurityDescriptor, :pointer,
        :bInheritHandle, :bool
      )
    end

    class MEMORY_BASIC_INFORMATION < FFI::Struct
      layout(
        :BaseAddress, :pointer,
        :AllocationBase, :pointer,
        :AllocationProtect, :ulong,
        :RegionSize, :size_t,
        :State, :ulong,
        :Protect, :dword,
        :Type, :dword
      )
    end
  end
end
