module NetLinx
  # A collection of resources loaded onto a NetLinx master.
  # Workspace -> Project -> System
  class System
    attr_accessor :name
    attr_accessor :id
    attr_accessor :description
    attr_accessor :files
    
    def initialize(**kvargs)
      @name        = kvargs.fetch :name,        ''
      @id          = kvargs.fetch :id,          ''
      @description = kvargs.fetch :description, ''
      
      @files = []
      
      @compiler_target_files  = []
      @compiler_include_paths = []
      @compiler_module_paths  = []
      @compiler_library_paths = []
    end
    
    # Alias to add a file.
    def <<(file)
      @files << file
    end
    
    # Returns the system name.
    def to_s
      @name
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