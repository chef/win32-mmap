require 'rubygems'

Gem::Specification.new do |spec|
  spec.name       = 'win32-mmap'
  spec.version    = '0.4.2'
  spec.author     = 'Daniel J. Berger'
  spec.license    = 'Artistic 2.0'
  spec.email      = 'djberg96@gmail.com'
  spec.homepage   = 'https://github.com/chef/win32-mmap'
  spec.summary    = 'Memory mapped IO for Windows.'
  spec.test_file  = 'test/test_win32_mmap.rb'
  spec.files      = Dir['**/*'].reject{ |f| f.include?('git') }

  spec.extra_rdoc_files  = ['MANIFEST', 'README.md', 'CHANGES']

  spec.add_dependency('ffi')
  spec.add_development_dependency('rake')
  spec.add_development_dependency('test-unit')

  spec.description = <<-EOF
    The win32-mmap library provides an interface for memory mapped IO on
    MS Windows.
  EOF
end
