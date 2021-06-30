require 'ffi'

module Windows
  module Constants
    include FFI::Library

    private

    GENERIC_READ  = 0x80000000
    GENERIC_WRITE = 0x40000000
    OPEN_ALWAYS   = 4

    WAIT_OBJECT_0 = 0

    INVALID_HANDLE_VALUE = FFI::Pointer.new(-1).address

    PAGE_NOACCESS          = 0x01
    PAGE_READONLY          = 0x02
    PAGE_READWRITE         = 0x04
    PAGE_WRITECOPY         = 0x08
    PAGE_EXECUTE           = 0x10
    PAGE_EXECUTE_READ      = 0x20
    PAGE_EXECUTE_READWRITE = 0x40
    PAGE_EXECUTE_WRITECOPY = 0x80
    PAGE_GUARD             = 0x100
    PAGE_NOCACHE           = 0x200
    PAGE_WRITECOMBINE      = 0x400

    SEC_FILE     = 0x800000
    SEC_IMAGE    = 0x1000000
    SEC_VLM      = 0x2000000
    SEC_RESERVE  = 0x4000000
    SEC_COMMIT   = 0x8000000
    SEC_NOCACHE  = 0x10000000

    FILE_MAP_COPY       = 0x0001
    FILE_MAP_WRITE      = 0x0002
    FILE_MAP_READ       = 0x0004
    FILE_MAP_ALL_ACCESS = 983071
  end
end
