# win32-mmap

[![Gem Version](https://badge.fury.io/rb/win32-mmap.svg)](https://badge.fury.io/rb/win32-mmap)

This package provides a Ruby interface for memory mapped I/O on MS Windows.

## Prerequisites

- ffi
- test-unit (Testing only)

## Installation

```
gem install win32-mmap
```

## Usage

```ruby
  require 'win32/mmap'
  include Win32

  map1 = MMap.new(:file => "C:\\test.map", :size => 1024)
  map1.foo = 'hello'
  map1.bar = 77
  map1.close

  map2 = MMap.new(:file => "C:\\test.map")
  p map2.foo # 'hello'
  p map2.bar # 77
  map2.close
```

## About Memory Mapped Files under Windows

Under Windows, code and data are both represented by pages of memory backed by files on disk, code by executable image and data by system pagefile (i.e. swapfile). These are called memory mapped files. Memory mapped files can be used to provide a mechanism for shared memory between processes. Different processes are able to share data backed by the same swapfile, whether it's the system pagefile or a user-defined swapfile.

Windows has a tight security system that prevents processes from directly sharing information among each other, but mapped memory files provide a mechanism that works with the Windows security system by using a name that all processes use to open the swapfile.

A shared section of the swapfile is translated into pages of memory that are addressable by more than one process, Windows uses a system resource called a prototype page table entry (PPTE) to enable more than one process to address the same physical page of memory, thus multiple process can share the same data without violating the Windows system security.

In short, memory mapped files provide shared memory under Windows.

(This explanation was largely borrowed from Roger Lee's Win32::MMF Perl module.)

## License

Artistic 2.0

## Copyright

(C) 2003-2013 Daniel J. Berger, All Rights Reserved

## Warranty

This package is provided "as is" and without any express or implied warranties, including, without limitation, the implied warranties of merchantability and fitness for a particular purpose.

## Authors

- Daniel J. Berger
- Park Heesob
