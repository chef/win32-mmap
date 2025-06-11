#######################################################################
# example_mmap_server.rb
#
# A test script for general futzing.  Run this in its own terminal
# then run the example_mmap_client.rb program in a separate terminal.
# You can run this program via the 'rake example_server' task.
#
# Modify as you see fit.
#######################################################################
require "win32/mmap"
include Win32

mmap = MMap.new(name: "alpha", size: 2000)

mmap.foo = "hello"
mmap.bar = 27

sleep 100

mmap.close
