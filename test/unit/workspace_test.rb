require 'test_helper'
require 'netlinx-compile/workspace'
require 'unit/netlinx_compilable'

describe NetLinx::Workspace do
  include NetLinxCompilable
  
  before do
    @workspace = @object = NetLinx::Workspace.new
  end
  
  after do
    @workspace = @object = nil
  end
  
  it "can be initialized from a .axw file" do
    @workspace = NetLinx::Workspace.new file: "test/unit/workspace/import-test/import-test.apw"
    
    # Contains the MasterSrc file to be compiled.
    
    # Contains include paths.
    
    # Contains module paths.
    
    skip
  end
  
end