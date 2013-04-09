require 'ffi'

module Windows
  module Structs
    class SECURITY_ATTRIBUTES < FFI::Struct
      layout(
        :nLength, :ulong,
        :lpSecurityDescriptor, :pointer,
        :bInheritHandle, :bool
      )
    end
  end
end
