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
          
          handler = nil
          eval "handler = NetLinx::Compile::Extension::#{ExtensionDiscovery.ext.upcase}.new"
          result = handler.invoke_compile target: File.expand_path(source, Dir.pwd)
          
          # -----------------------------
          # TODO: Print compiler results.
          # -----------------------------
        end
      end
      
    end
  end
end