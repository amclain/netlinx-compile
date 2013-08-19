require 'netlinx/compile/extension_discovery'

module NetLinx
  module Compile
    # The container for the script that runs when netlinx-compile is executed.
    class Script
      private_class_method :new
      
      class << self
        # Run the script.
        def run(**kvargs)
          source = ARGV.first
          ExtensionDiscovery.load_handler source
          eval "@handler = NetLinx::Compile::Extension::#{ExtensionDiscovery.ext.upcase}.new"
          @handler.invoke_compile target: source
        end
      end
      
    end
  end
end