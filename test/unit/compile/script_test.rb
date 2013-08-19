require 'test_helper'
require 'netlinx/compile/script'

describe NetLinx::Compile::Script do
  before do
    @path = 'test\unit\workspace\script'
    @script = @object = NetLinx::Compile::Script
  end
  
  after do
    @script = @object = nil
  end
  
  it "is invoked by calling #run" do
    assert_respond_to @script, :run
  end
  
  it "is a singleton" do
    Proc.new {
      NetLinx::Compile::Script.new
    }.must_raise NoMethodError
  end
  
	it "selects and triggers an Invokable to compile itself based on file extension" do
    source = File.expand_path 'script.axs', @path
    destination = File.expand_path 'script.tkn', @path
    File.delete destination if File.exists? destination
    
    ARGV = [source]
    @script.run
    
    File.exists?(destination).must_equal true
	end
end