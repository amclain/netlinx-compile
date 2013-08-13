require 'rexml/document'

module NetLinx
  class Workspace
    attr_reader :compiler_target_files
    attr_reader :compiler_include_paths
    attr_reader :compiler_module_paths
    attr_reader :compiler_library_paths
    
    def initialize(**kvargs)
      @doc = REXML::Document.new
      
      @compiler_target_files  = []
      @compiler_include_paths = []
      @compiler_module_paths  = []
      @compiler_library_paths = []
      
      @file = kvargs.fetch("file", nil)
      load_workspace @file if @file
    end
    
    private
    
    # Load the workspace from a given NetLinx Studio .apw file.
    def load_workspace(file)
      raise LoadError, "File does not exist at:\n#{file}" unless File.exists? file
      
      File.open file, 'r' do |f|
        @doc = REXML::Document.new f
      end
      
      @compiler_target_files  = []
      @compiler_include_paths = []
      @compiler_module_paths  = []
      @compiler_library_paths = []
      
      @doc.each_element '/Workspace/Project/System/File' do |workspace_file|
        file_path_name = workspace_file.each_element('FilePathName').first.text
        type = workspace_file.attribute 'Type'
        
        @compiler_target_files << file_path_name if type == 'MasterSrc'
        @compiler_include_paths << file_path_name if type == 'Include'
        @compiler_module_paths << file_path_name if type == 'DUET' || type == 'Module'
      end
    end
    
  end
end