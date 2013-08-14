require 'rexml/document'
require 'netlinx/project'

module NetLinx
  
  # A NetLinx Studio workspace.
  # Collection of projects.
  # Workspace -> Project -> System
  class Workspace
    attr_accessor :name
    attr_accessor :description
    attr_accessor :projects
    
    def initialize(**kvargs)
      @name         = kvargs.fetch :name, ''
      @description  = kvargs.fetch :description, ''
      @projects     = []
      
      @doc = REXML::Document.new
      
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
      # 
      # File Element Types:
      # MasterSrc - (.axs) The master source code file for the system.
      # DUET      - (.jar) Cafe Duet module.
      # Include   - (.axi) NetLinx include file.
      # Module    - (.axs) NetLinx module source code file.
      # TKO       - (.tko) NetLinx compiled module.
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
          type == 'DUET' || type == 'Module' || type == 'TKO'
          
        # File lists should not contain duplicates.
        @compiler_target_files.uniq!
        @compiler_include_paths.uniq!
        @compiler_module_paths.uniq!
        @compiler_library_paths.uniq!
      end
    end
    
  end
end