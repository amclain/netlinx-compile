module NetLinx
  class SourceFile
    
    def initialize(**kvargs)
      @compiler_target_files  = kvargs.fetch :compiler_target_files,  []
      @compiler_include_paths = kvargs.fetch :compiler_include_paths, []
      @compiler_module_paths  = kvargs.fetch :compiler_module_paths,  []
    end
    
    def compiler_target_files
      @compiler_target_files
    end
    
    def compiler_include_paths
      @compiler_include_paths
    end
    
    def compiler_module_paths
      @compiler_module_paths
    end
    
    def compiler_library_paths
      []
    end
    
    def compile
      require 'netlinx/compiler'
      compiler = NetLinx::Compiler.new
      result = compiler.compile self
    end
    
  end
end