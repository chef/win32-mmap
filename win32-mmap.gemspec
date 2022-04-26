lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "win32/windows/version"

Gem::Specification.new do |spec|
  spec.name       = 'win32-mmap'
  spec.version    = Win32::MMap::VERSION
  spec.author     = 'Daniel J. Berger'
  spec.license    = 'Artistic 2.0'
  spec.email      = 'djberg96@gmail.com'
  spec.homepage   = 'https://github.com/chef/win32-mmap'
  spec.summary    = 'Memory mapped IO for Windows.'
  spec.test_file  = 'test/test_win32_mmap.rb'
  spec.files      = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(\..*|Gemfile|Rakefile|doc|examples|VERSION|test)}) }

  spec.extra_rdoc_files  = ['README.md']

  spec.add_dependency('ffi')
  spec.add_development_dependency('rake')
  spec.add_development_dependency('test-unit')

  spec.description = <<-EOF
    The win32-mmap library provides an interface for memory mapped IO on
    MS Windows.
  EOF
end
