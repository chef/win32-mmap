require 'rake'
require 'rake/clean'
require 'rake/testtask'

CLEAN.include('**/*.gem')

namespace 'gem' do
  desc 'Create the win32-mmap gem.'
  task :create => [:clean] do
    spec = eval(IO.read('win32-mmap.gemspec'))
    if Gem::VERSION.to_f < 2.0
      Gem::Builder.new(spec).build
    else
      require 'rubygems/package'
      Gem::Package.build(spec)
    end
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

task :default => :test
