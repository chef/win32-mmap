#######################################################################
# example_mmap_client.rb
#
# This program demonstrates a simple mmap client. You should run this
# program *after* you have run the example server program in a
# separate terminal.
#
# You can run this program via the 'rake example_client' task.
#
# Modify this program as you see fit.
#######################################################################
require "win32/mmap"
include Win32

mmap = MMap.open("alpha")

p mmap.foo
p mmap.bar

mmap.close
