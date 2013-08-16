module NetLinx
  # Contains info pertaining to a job run through the compiler.
  class CompilerResult
    attr_reader :stream
    attr_reader :errors
    attr_reader :warnings
    
    # Implement Compilable interface.
    attr_reader :compiler_target_files
    attr_reader :compiler_include_paths
    attr_reader :compiler_module_paths
    attr_reader :compiler_library_paths
    
    def initialize(**kvargs)
      @stream   = kvargs.fetch :stream,   ''
      @errors   = kvargs.fetch :errors,   nil
      @warnings = kvargs.fetch :warnings, nil
      
      @compiler_target_files  = kvargs.fetch :compiler_target_files,  []
      @compiler_include_paths = kvargs.fetch :compiler_include_paths, []
      @compiler_module_paths  = kvargs.fetch :compiler_module_paths,  []
      @compiler_library_paths = kvargs.fetch :compiler_library_paths, []      
    end
    
    # Returns the absolute path of the source code file that was compiled.
    def target_file
      @compiler_target_files.first
    end
    
    # Compile was successful?
    def success?
      @errors == 0 && @warnings == 0
    end
    
  end
end