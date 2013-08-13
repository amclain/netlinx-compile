require 'test_helper'
require 'netlinx-compile/workspace'
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
      ), "Contains include paths."
    
    # Contains module paths.
    assert @workspace.compiler_include_paths.include?(
      File.expand_path('duet-module', @workspace_path)
      ), "Contains module paths."
  end
  
end