require 'rake'
require 'rake/testtask'

namespace 'gem' do
  desc 'Delete any gem files in the project.'
  task :clean do
    Dir['*.gem'].each{ |f| File.delete(f) }
  end

  desc 'Create the win32-mmap gem.'
  task :create => [:clean] do
    spec = eval(IO.read('win32-mmap.gemspec'))
    Gem::Builder.new(spec).build
  end

  desc 'Install the win32-mmap gem.'
  task :install => [:create] do
    file = Dir['*.gem'].first
    sh "gem install #{file}"
  end
end

namespace 'example' do
  desc 'Run the example mmap file program'
  task :file do
    ruby '-Ilib examples/example_mmap_file.rb'
  end

  desc 'Run the example mmap server'
  task :server do
    ruby '-Ilib examples/example_mmap_server.rb'
  end

  desc 'Run the example mmap client'
  task :client do
    ruby '-Ilib examples/example_mmap_client.rb'
  end
end

Rake::TestTask.new do |t|
  t.verbose = true
  t.warning = true
end
