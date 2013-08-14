require 'ostruct'

module NetLinx
  # A collection of resources loaded onto a NetLinx master.
  # Workspace -> Project -> System
  class System
    attr_accessor :name
    attr_accessor :id
    attr_accessor :description
    attr_accessor :project        # A reference to the system's parent project.
    attr_accessor :files
    
    def initialize(**kvargs)
      @name        = kvargs.fetch :name,        ''
      @id          = kvargs.fetch :id,          ''
      @description = kvargs.fetch :description, ''
      @project     = kvargs.fetch :project,     nil
      
      @files = []
      
      @compiler_target_files  = []
      @compiler_include_paths = []
      @compiler_module_paths  = []
      @compiler_library_paths = []
      
      system_element = kvargs.fetch :element, nil
      parse_xml_element system_element if system_element
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
      @files
        .select {|f| f.type == 'MasterSrc'}
        .map {|f| File.extend_path f.path, @project.workspace.path}
    end
    
    def compiler_include_paths
      @files
        .select {|f| f.type == 'Include'}
        .map {|f| File.extend_path f.path, @project.workspace.path}
    end
    
    def compiler_module_paths
      @files
        .select {|f| f.type == 'Module' || f.type == 'TKO' || f.type == 'DUET'}
        .map {|f| File.extend_path f.path, @project.workspace.path}
    end
    
    def compiler_library_paths
      []
    end
    
    private
    
    def parse_xml_element(system)
      # Load system params.
      @name = system.elements['Identifier'].text.strip
      @id = system.elements['SysID'].text.strip.to_i
      @description = system.elements['Comments'].text
      
      # Create system files.
      system.each_element 'File' do |e|
        file_type = e.attributes['Type']
        file_name = e.elements['Identifier'].text
        file_path = e.elements['FilePathName'].text
        file_description = e.elements['Comments'].text
        
        f = OpenStruct.new \
          type: file_type,
          name: file_name,
          path: file_path,
          description: file_description
        
        @files << f
      end
    end
    
  end
end