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
    skip
  end
  
  it "contans the MasterSrc file to be compiled" do
    skip
  end
  
  it "contains include paths" do
    skip
  end
  
  it "contains module paths" do
    skip
  end
  
end