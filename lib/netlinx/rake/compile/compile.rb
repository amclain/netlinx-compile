
require 'rake'
require 'rake/tasklib'

require 'netlinx/compile/script'

module NetLinx
  module Rake
    
    # Compile to deployable code from the source code files in the given workspace.
    class Compile < ::Rake::TaskLib
      
      attr_accessor :name
      
      def initialize name = :compile
        @name = name
        yield self if block_given?
        
        desc "Compile to deployable code from the source code files in the given workspace."
        
        task(name) do
          workspace = Dir.glob("*.apw").first
          
          puts "\n\nLaunching NetLinx compiler...\n\n"
          # TODO: Invoke compiler through API.
          #       Just call the netlinx-compile rake task in rake/erb.
          system "netlinx-compile --smart -s \"#{workspace}\""
          # NetLinx::Compile::Script.run argv: ['--smart', '-s', "\"#{workspace}\""]
        end
        
      end
    end
  end
end
