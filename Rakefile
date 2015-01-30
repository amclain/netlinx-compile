require 'rspec/core/rake_task'
require 'yard'

task :default => [:integration]

# Run unit tests.
# Friendly for CI tools without installing NetLinx compiler.
# RSpec::Core::RakeTask.new :ci do |c|
#   c.rspec_opts = '--color --format Fivemat'
# end
task :ci do
  ENV['INTEGRATION_TEST'] = nil
  Rake::Task[:test].invoke
end

# Run integration tests.
# Requires NetLinx compiler to be installed on system.
task :integration do
  ENV['INTEGRATION_TEST'] = 'true'
  Rake::Task[:test].invoke
end

RSpec::Core::RakeTask.new :test do |c|
  c.rspec_opts = '--color --format Fivemat'
end

# Build the gem.
task :build => :doc do
  # system 'markup README.md --force'
  
  Dir['*.gem'].each {|file| File.delete file}
  system 'gem build *.gemspec'
end

# Rebuild and [re]install the gem.
task :install => :build do
  system 'gem install *.gem'
end

# Generate documentation.
YARD::Rake::YardocTask.new :doc do |t|
  t.options = %w(- license.txt)
end
