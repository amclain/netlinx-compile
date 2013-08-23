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
            
            opts.on '-i', '--include [PATHS]', Array, 'Additional include and module paths.' do |v|
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
          handler = NetLinx::Compile::ExtensionDiscovery.handlers
            .select{|h| not h.nil?}
            .select{|h| h.extensions.include? self.parse_extension(@options.source)}
            .first
          
          # Instantiate the class that can handle compiling of the file.
          handler_class = handler.handler_class.new \
            file: File.expand_path(@options.source, Dir.pwd)
          
          result = handler_class.compile
          
          result.each {|r| puts r}
        end
        
        def parse_extension(file_extension)
          ext = file_extension.scan(/(?:^\s*|(?<=\.))(\w+)$/).first
          raise ArgumentError, "Could not parse a file extension from the string: #{file_extension}" unless ext
          
          ext.first
        end
        
      end
      
    end
  end
end