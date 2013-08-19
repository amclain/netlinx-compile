require 'netlinx/compiler'
require 'ostruct'

module NetLinx
  module Compile
    module Extension
      # Instructs netlinx-compile on how to process .axs NetLinx source code files.
      class AXS
        def invoke_compile(**kvargs)
          target = kvargs.fetch(:target, nil)
          raise ArgumentError, "Invalid target: #{target}." unless target
          
          compilable = OpenStruct.new \
            compiler_target_files:  [target],
            compiler_include_paths: [],
            compiler_module_paths:  [],
            compiler_library_paths: []
          
          @compiler = NetLinx::Compiler.new
          @compiler.compile compilable
        end
      end
    end
  end
end