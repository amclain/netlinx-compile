module NetLinx
  class SourceFile
    
    # Include directive regex:
    # (?i)^\s*(?:\#include)\s+'([\w\-]+)'
    
    # Define_Module regex:
    # (?i)^\s*(?:define_module)\s+'([\w\-]+)'
    
    def initialize(**kvargs)
      @compiler_target_files  = [ (kvargs.fetch :file, nil) ]
      @compiler_include_paths = kvargs.fetch :compiler_include_paths, []
      @compiler_module_paths  = kvargs.fetch :compiler_module_paths,  []
      
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