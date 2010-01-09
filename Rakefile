require 'rake'
require 'rake/testtask'
require 'rbconfig'
include Config

desc 'Install the win32-mmap package (non-gem)'
task :install do
   sitelibdir = CONFIG['sitelibdir']
   installdir = File.join(sitelibdir, 'win32')
   file = 'lib\win32\mmap.rb'

   Dir.mkdir(installdir) unless File.exists?(installdir)
   FileUtils.cp(file, installdir, :verbose => true)
end

desc 'Run the example mmap file program'
task :example_file do
   ruby '-Ilib examples/example_mmap_file.rb'end

desc 'Run the example mmap server'
task :example_server do
   ruby '-Ilib examples/example_mmap_server.rb'end

desc 'Run the example mmap client'
task :example_client do
   ruby '-Ilib examples/example_mmap_client.rb'end

Rake::TestTask.new do |t|
   t.verbose = true
   t.warning = true
end
