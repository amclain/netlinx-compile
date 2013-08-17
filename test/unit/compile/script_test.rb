require 'test_helper'
require 'netlinx/compile/script'

describe NetLinx::Compile::Script do
  before do
    @script = @object = NetLinx::Compile::Script
  end
  
  after do
    @script = @object = nil
  end
  
  it "is invoked by calling #run" do
    assert_respond_to @script, :run
  end
  
	it "selects and triggers an Invokable to compile itself based on file extension" do
    skip
	end
end