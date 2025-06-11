#######################################################################
# example_mmap_file.rb
#
# This sample script demonstrates creating a memory mapped file, then
# later reading from it. You can run this example via the
# 'rake example_file' task.
#
# Modify this program as you see fit.
#######################################################################
require "win32/mmap"
include Win32

map1 = MMap.new(file: "C:\\mmap.test", size: 1024)

map1.foo = "hello"
map1.bar = 77

map1.close

map2 = MMap.new(file: "C:\\mmap.test")

p map2.foo
p map2.bar

map2.close
