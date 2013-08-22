module NetLinx
  class SourceFile
    
    # Include directive regex:
    # (?i)^\s*(\#include)\s+'([\w\-]+)'
    
    # Define_Module regex:
    # (?i)^\s*(define_module)\s+'([\w\-]+)'
    
    def initialize(**kvargs)
      @compiler_target_files  = [ (kvargs.fetch :file, nil) ]
      @compiler_include_paths = kvargs.fetch :compiler_include_paths, []
      @compiler_module_paths  = kvargs.fetch :compiler_module_paths,  []
      
      # Scan file for additional include paths.
      
      # Scan file for additional module paths.
      
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