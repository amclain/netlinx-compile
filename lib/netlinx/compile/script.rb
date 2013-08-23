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
          args = kvargs.fetch :argv, ARGV.first
          
          source = args.first
          
          # Find an ExtensionHandler for the given file.
          ExtensionDiscovery.discover
          handler = NetLinx::Compile::ExtensionDiscovery.handlers
            .select{|h| not h.nil?}
            .select{|h| h.extensions.include? self.parse_extension(source)}
            .first
          
          # Instantiate the class that can handle compiling of the file.
          handler_class = handler.handler_class.new \
            file: File.expand_path(source, Dir.pwd)
          
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