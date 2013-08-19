module NetLinx
  module Compile
    # Discovers and auto-requires add-on Ruby libraries for netlinx-compile
    # based on a file extension.
    class ExtensionDiscovery
      private_class_method :new
      
      class << self
        # Loads (requires) a library based on the given file extension.
        # The extension can be provided with or without the leading dot.
        # Returns true if a library was loaded.
        # Raises LoadError if no handler library is found.
        def load_handler(extension)
          ext = extension.scan(/(\w+)$/).first
          
          # No value was matched.
          raise ArgumentError unless ext
          
          ext = ext.first
          
          require "netlinx/compile/extension/#{ext}"
          true
        end
      end
    end
  end
end