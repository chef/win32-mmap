require "rubygems"
require 'rake'
require 'rake/clean'
require 'rake/testtask'

CLEAN.include('**/*.gem')

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
