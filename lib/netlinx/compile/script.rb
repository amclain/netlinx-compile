require 'optparse'
require 'ostruct'
require 'netlinx/compile/extension_discovery'

module NetLinx
  module Compile
    # The container for the script that runs when netlinx-compile is executed.
    class Script
      private_class_method :new
      
      class << self
        # Run the script.
        def run(**kvargs)
          # :argv is a convenience to override ARGV, like for testing.
          args = kvargs.fetch :argv, ARGV

          # Command line options.
          @options = OpenStruct.new \
            source: '',
            include_paths: [],
            use_workspace: false
          
          OptionParser.new do |opts|
            opts.banner = "Usage: netlinx-compile [options]"
            
            opts.on '-h', '--help', 'Display this help screen.' do
              puts opts
              exit
            end
            
            opts.on '-s', '--source FILE', 'Source file to compile.' do |v|
              @options.source = v
            end
            
            opts.on '-i', '--include [Path1,Path2]', Array, 'Additional include and module paths.' do |v|
              @options.include_paths = v
            end
            
            opts.on '-w', '--workspace', '--smart',
                    'Search up directory tree for a workspace',
                    'containing the source file.' do |v|
              @options.use_workspace = v
            end
            
          end.parse! args
          
          if @options.source.empty?
            puts "No source file specified.\nRun \"netlinx-compile -h\" for help."
            exit
          end
          
          # Find an ExtensionHandler for the given file.
          ExtensionDiscovery.discover
          handler = NetLinx::Compile::ExtensionDiscovery.get_handler @options.source
          
          # If the handler is a workspace handler, go straight to compiling it.
          # Otherwise, if the use_workspace flag is true, search up through the
          # directory tree to try to find a workspace that includes the
          # specified source file.
          if not handler.is_a_workspace? && @options.use_workspace
            
          end
          
          # Instantiate the class that can handle compiling of the file.
          handler_class = handler.handler_class.new \
            file: File.expand_path(@options.source, Dir.pwd)
          
          result = handler_class.compile
          
          result.map {|r| r.to_s}
        end
        
      end
      
    end
  end
end