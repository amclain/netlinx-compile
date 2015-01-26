module NetLinx
  # A NetLinx source code file.
  # Typically .axs or .axi.
  class SourceFile
    
    # NOTE: SourceFile searches the body of the source file to automatically
    # determine include and module paths.
    # 
    # @option kwargs [String] :file Name or path of the file to compile.
    # @option kwargs [Array<String>] :compiler_include_paths Additional paths for the compiler to find include files.
    # @option kwargs [Array<String>] :compiler_module_paths Additional paths for the compiler to find module files.
    def initialize(**kwargs)
      @compiler_target_files  = [ kwargs.fetch(:file, nil) ]
      @compiler_include_paths = kwargs.fetch :compiler_include_paths, []
      @compiler_module_paths  = kwargs.fetch :compiler_module_paths,  []
      
      return unless @compiler_target_files.first
      
      source_code = File.open(@compiler_target_files.first).read
      
      # Scan file for additional include paths.
      includes = source_code.scan(/(?i)^\s*(?:\#include)\s+'([\w\-]+)'/)
      
      includes.each do |inc|
        inc = inc.first
        
        path = Dir["./**/#{inc}.*"].first
        next unless path
        
        path = File.expand_path path
        @compiler_include_paths << File.dirname(path)
      end
      
      @compiler_include_paths.uniq!
      
      # Scan file for additional module paths.
      modules = source_code.scan(/(?i)^\s*(?:define_module)\s+'([\w\-]+)'/)
      
      modules.each do |mod|
        mod = mod.first
        
        path = Dir["./**/#{mod}.*"].first
        next unless path
        
        path = File.expand_path path
        @compiler_module_paths << File.dirname(path)
      end
      
      @compiler_module_paths.uniq!
    end
    
    # @see _ lib/test/netlinx/compilable.rb interface.
    def compiler_target_files
      @compiler_target_files
    end
    
    # @see _ lib/test/netlinx/compilable.rb interface.
    def compiler_include_paths
      @compiler_include_paths
    end
    
    # @see _ lib/test/netlinx/compilable.rb interface.
    def compiler_module_paths
      @compiler_module_paths
    end
    
    # @see _ lib/test/netlinx/compilable.rb interface.
    def compiler_library_paths
      []
    end
    
    # Execute the compiler on itself.
    def compile
      require 'netlinx/compiler'
      compiler = NetLinx::Compiler.new
      result = compiler.compile self
    end
    
  end
end