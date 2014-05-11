require 'rake/testtask'
require 'yard'

task :default => [:test]

# Run tests.
task :test do
  Rake::TestTask.new do |t|
    t.pattern = 'test/**/*_test.rb'
    t.libs << './test'
  end
end

# Build the gem.
task :build => [:doc] do
  # system 'markup README.md --force'
  
  Dir['*.gem'].each {|file| File.delete file}
  system 'gem build *.gemspec'
end

# Rebuild and [re]install the gem.
task :install => [:build] do
  system 'gem install *.gem'
end

# Generate documentation.
YARD::Rake::YardocTask.new :doc do |t|
  t.options = %w(- README.md license.txt)
end
