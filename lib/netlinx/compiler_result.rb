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
      
      @compiler_target_files  = kvargs.fetch :compiler_target_files,  []
      @compiler_include_paths = kvargs.fetch :compiler_include_paths, []
      @compiler_module_paths  = kvargs.fetch :compiler_module_paths,  []
      @compiler_library_paths = kvargs.fetch :compiler_library_paths, []      
      
      # Capture error and warning counts.
      @errors = nil
      @warnings = nil
      
      @stream.scan /(\d+) error\(s\), (\d+) warning\(s\)/ do |e, w|
        @errors   = e.to_i if e
        @warnings = w.to_i if w
      end
    end
    
    # Returns the absolute path of the source code file that was compiled.
    def target_file
      @compiler_target_files.first
    end
    
    # Compile was successful?
    def success?
      @errors == 0 && @warnings == 0
    end
    
    # An enumerable list of warnings.
    def warning_items
      @stream.scan(/(^WARNING: .*$)/).map {|i| i.first}
    end
    
    # An enumerable list of errors.
    def error_items
      @stream.scan(/(^ERROR: .*$)/).map {|i| i.first}
    end
    
  end
end