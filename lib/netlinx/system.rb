module NetLinx
  # A collection of resources loaded onto a NetLinx master.
  # Workspace -> Project -> System
  class System
    attr_reader :compiler_target_files
    attr_reader :compiler_include_paths
    attr_reader :compiler_module_paths
    attr_reader :compiler_library_paths
    
    def initialize
      @compiler_target_files  = []
      @compiler_include_paths = []
      @compiler_module_paths  = []
      @compiler_library_paths = []
    end
  end
end