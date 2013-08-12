module NetLinx
  class Workspace
    
    def initialize(**kvargs)
      @filename = kvargs.fetch("filename", nil)
    end
    
    def compiler_target_files
      []
    end
    
    def compiler_include_paths
      []
    end
    
    def compiler_module_paths
      []
    end
    
    def compiler_library_paths
      []
    end
    
  end
end