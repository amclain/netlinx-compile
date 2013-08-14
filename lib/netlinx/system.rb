module NetLinx
  # A collection of resources loaded onto a NetLinx master.
  # Workspace -> Project -> System
  class System
    
    def initialize
      @files = []
      
      @compiler_target_files  = []
      @compiler_include_paths = []
      @compiler_module_paths  = []
      @compiler_library_paths = []
    end
    
    def <<(file)
      @files << file
    end
    
    def compiler_target_files
      @files.select {|f| f.type == 'MasterSrc'}
        .map {|f| f.file_path_name}
    end
    
    def compiler_include_paths
      @files.select {|f| f.type == 'Include'}
        .map {|f| f.file_path_name}
    end
    
    def compiler_module_paths
      @files.select {|f| f.type == 'Module' || f.type == 'TKO' || f.type == 'DUET'}
        .map {|f| f.file_path_name}
    end
    
    def compiler_library_paths
      []
    end
  end
end