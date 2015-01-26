module NetLinx
  # Contains info pertaining to a job run through the compiler.
  class CompilerResult
    # The raw stream of text returned by the compiler.
    attr_reader :stream
    # Number of compiler errors.
    attr_reader :errors
    # Number of compiler warnings.
    attr_reader :warnings
    
    # Implement the Compilable interface.
    
    # See Compilable interface.
    attr_reader :compiler_target_files
    # See Compilable interface.
    attr_reader :compiler_include_paths
    # See Compilable interface.
    attr_reader :compiler_module_paths
    # See Compilable interface.
    attr_reader :compiler_library_paths
    
    # @option kwargs [String] :stream The raw stream of text returned by the compiler.
    # @option kwargs [Array<String>] :compiler_target_files  See Compilable interface.
    # @option kwargs [Array<String>] :compiler_include_paths See Compilable interface.
    # @option kwargs [Array<String>] :compiler_module_paths  See Compilable interface.
    # @option kwargs [Array<String>] :compiler_library_paths See Compilable interface.
    def initialize(**kwargs)
      @stream   = kwargs.fetch :stream, ''
      
      @compiler_target_files  = kwargs.fetch :compiler_target_files,  []
      @compiler_include_paths = kwargs.fetch :compiler_include_paths, []
      @compiler_module_paths  = kwargs.fetch :compiler_module_paths,  []
      @compiler_library_paths = kwargs.fetch :compiler_library_paths, []      
      
      # Capture error and warning counts.
      @errors = nil
      @warnings = nil
      
      @stream.scan /(\d+) error\(s\), (\d+) warning\(s\)/ do |e, w|
        @errors   = e.to_i if e
        @warnings = w.to_i if w
      end
    end
    
    # Alias of {#stream}.
    def to_s
      @stream
    end
    
    # @return [String] the absolute path of the source code file that was compiled.
    def target_file
      @compiler_target_files.first
    end
    
    # @return [Boolean] true if compile was successful.
    def success?
      @errors == 0 && @warnings == 0
    end
    
    # @return [Array<String>] a list of warnings.
    def warning_items
      @stream.scan(/(^WARNING: .*$)/).map {|i| i.first}
    end
    
    # @return [Array<String>] a list of errors.
    def error_items
      @stream.scan(/(^ERROR: .*$)/).map {|i| i.first}
    end
    
  end
end