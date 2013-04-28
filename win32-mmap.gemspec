require 'rubygems'

Gem::Specification.new do |spec|
  spec.name      = 'win32-mmap'
  spec.version   = '0.3.2'
  spec.author    = 'Daniel J. Berger'
  spec.license   = 'Artistic 2.0'
  spec.email     = 'djberg96@gmail.com'
  spec.homepage  = 'https://github.com/djberg96/win32-mmap'
  spec.summary   = 'Memory mapped IO for Windows.'
  spec.test_file = 'test/test_win32_mmap.rb'
  spec.files     = Dir['**/*'].reject{ |f| f.include?('git') }

  spec.rubyforge_project = 'win32utils'
  spec.extra_rdoc_files  = ['MANIFEST', 'README', 'CHANGES']

  spec.add_dependency('ffi')

  spec.description = <<-EOF
    The win32-mmap library provides an interface for memory mapped IO on
    MS Windows.
  EOF
end
