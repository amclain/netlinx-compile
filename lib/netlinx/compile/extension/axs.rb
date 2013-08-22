require 'netlinx/compile/extension_handler'
require 'netlinx/source_file'

module NetLinx
  module Compile
    module Extension
      # Instructs netlinx-compile on how to process .axs NetLinx source code files.
      class AXS
        # :nodoc:
        def self.get_handler
          handler = NetLinx::Compile::ExtensionHandler.new \
            extensions: ['axs', 'axi'],
            handler_class: NetLinx::SourceFile
        end
      end
    end
  end
end