require 'test_helper'
require 'netlinx/workspace'
require 'unit/compilable'

describe NetLinx::Workspace do
  include NetLinx::Compilable
  
  before do
    @workspace = @object = NetLinx::Workspace.new
    @workspace_path = 'test/unit/workspace/import-test'
  end
  
  after do
    @workspace = @object = nil
  end
  
  it "can be initialized from a .axw file" do
    @workspace = NetLinx::Workspace.new \
      file: File.expand_path('import-test.apw', @workspace_path)
    
    # Contains the MasterSrc file to be compiled.
    assert @workspace.compiler_target_files.include?(
      File.expand_path('import-test.axs', @workspace_path)
      ), "Contains the MasterSrc file to be compiled."
    
    # Contains include paths.
    assert @workspace.compiler_include_paths.include?(
      File.expand_path('include', @workspace_path)
      ), "Contains source code include path."
    
    # Contains module paths.
    assert @workspace.compiler_module_paths.include?(
      File.expand_path('duet-module', @workspace_path)
      ), "Contains duet module path."
    
    assert @workspace.compiler_module_paths.include?(
      File.expand_path('module-compiled', @workspace_path)
      ), "Contains compiled module path."
    
    assert @workspace.compiler_module_paths.include?(
      File.expand_path('module-source', @workspace_path)
      ), "Contains source code module path."
  end
  
  # TODO:
  # Iterate projects in a workspace,
  # iterate systems in each project,
  # build each system.
  #
  # Each system will actually be a Compilable, not the
  # whole workspace. Actually, the whole workspace is
  # a collection of Compilables.
  #
  # The NetLinx system (inside workspace) is actually what
  # contains the structure of the project's files and master
  # info. Workspace is just a container of projects/systems.
  
end