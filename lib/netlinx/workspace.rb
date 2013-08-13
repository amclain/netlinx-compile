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
      
      @file = kvargs.fetch :file, nil
      load_workspace @file if @file
    end
    
    private
    
    # Load the workspace from a given NetLinx Studio .apw file.
    def load_workspace(file)
      raise LoadError, "File does not exist at:\n#{file}" unless File.exists? file
      
      File.open file, 'r' do |f|
        @doc = REXML::Document.new f
      end
      
      # Clear file lists.
      @compiler_target_files  = []
      @compiler_include_paths = []
      @compiler_module_paths  = []
      @compiler_library_paths = []
      
      # Retrieve the File elements from the workspace.
      file_path_name = nil
      @doc.each_element '/Workspace/Project/System/File' do |workspace_file|
        workspace_file.each_element('FilePathName') do |e|
          file_path_name = File.expand_path e.text, File.dirname(file)
          break
        end
        
        # Add the path to the corresponding file list based on type.
        type = workspace_file.attribute('Type').to_s
       
        @compiler_target_files << file_path_name if
          type == 'MasterSrc'
        @compiler_include_paths << File.dirname(file_path_name) if
          type == 'Include'
        @compiler_module_paths << File.dirname(file_path_name) if
          type == 'DUET' || type == 'Module'
          
        # File lists should not contain duplicates.
        @compiler_target_files.uniq!
        @compiler_include_paths.uniq!
        @compiler_module_paths.uniq!
        @compiler_library_paths.uniq!
      end
    end
    
  end
end