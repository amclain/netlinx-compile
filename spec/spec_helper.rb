require 'pry'

RSpec.configure do |c|
  # Only run tests marked with iso:true.
  c.filter_run_including iso:true
  c.run_all_when_everything_filtered = true
  
  # Abort after first failure.
  # (Use environment variable for developer preference)
  c.fail_fast = true if ENV['RSPEC_FAIL_FAST']
  
  # Set output formatter and enable color.
  # c.formatter = 'Fivemat'
  # c.color     = true
end
