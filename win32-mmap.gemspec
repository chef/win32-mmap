require 'rubygems'

spec = Gem::Specification.new do |gem|
   gem.name      = 'win32-mmap'
   gem.version   = '0.2.3'
   gem.author    = 'Daniel J. Berger'
   gem.license   = 'Artistic 2.0'
   gem.email     = 'djberg96@gmail.com'
   gem.homepage  = 'http://www.rubyforge.org/projects/win32utils'
   gem.platform  = Gem::Platform::RUBY
   gem.summary   = 'Memory mapped IO for Windows.'
   gem.test_file = 'test/test_win32_mmap.rb'
   gem.has_rdoc  = true
   gem.files     = Dir['**/*'].reject{ |f| f.include?('CVS') }

   gem.rubyforge_project = 'win32utils'
   gem.extra_rdoc_files  = ['MANIFEST', 'README', 'CHANGES']

   gem.add_dependency('windows-pr')

   gem.description = <<-EOF
      The win32-mmap library provides an interface for memory mapped IO on
      MS Windows.
   EOF
end

Gem::Builder.new(spec).build
