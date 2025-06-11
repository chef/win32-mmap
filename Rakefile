require "rake/clean"
require "rake/testtask"

CLEAN.include("**/*.gem")

namespace "example" do
  desc "Run the example mmap file program"
  task :file do
    ruby "-Ilib examples/example_mmap_file.rb"
  end

  desc "Run the example mmap server"
  task :server do
    ruby "-Ilib examples/example_mmap_server.rb"
  end

  desc "Run the example mmap client"
  task :client do
    ruby "-Ilib examples/example_mmap_client.rb"
  end
end

Rake::TestTask.new do |t|
  t.verbose = true
  t.warning = true
end

begin
  require "yard"
  YARD::Rake::YardocTask.new(:docs)
rescue LoadError
  puts "yard is not available. bundle install first to make sure all dependencies are installed."
end

desc "Check Linting and code style."
task :style do
  require "rubocop/rake_task"
  require "cookstyle/chefstyle"

  if RbConfig::CONFIG["host_os"] =~ /mswin|mingw|cygwin/
    # Windows-specific command, rubocop erroneously reports the CRLF in each file which is removed when your PR is uploaeded to GitHub.
    # This is a workaround to ignore the CRLF from the files before running cookstyle.
    sh "cookstyle --chefstyle -c .rubocop.yml --except Layout/EndOfLine"
  else
    sh "cookstyle --chefstyle -c .rubocop.yml"
  end
rescue LoadError
  puts "Rubocop or Cookstyle gems are not installed. bundle install first to make sure all dependencies are installed."
end

task :console do
  require "irb"
  require "irb/completion"
  ARGV.clear
  IRB.start
end

task default: :test
