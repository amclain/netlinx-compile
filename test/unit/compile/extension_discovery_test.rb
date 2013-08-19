require 'test_helper'
require 'netlinx/compile/extension_discovery'

describe NetLinx::Compile::ExtensionDiscovery do
  before do
    @extension_discovery = @object = NetLinx::Compile::ExtensionDiscovery.new
  end
  
  after do
    @extension_discovery = @object = nil
  end
  
  it "performs a Ruby require based on a file extension" do
    # Example:
    # Passing the file name "workspace.apw" would cause the following to happen:
    # require '/netlinx/compile/extension/apw'
    #
    # An external gem would implement the apw.rb file at the require path,
    # allowing netlinx-compile to dynamically figure out how to process
    # different file types.
    
    
    # ------------------------------------------
    # TODO: Need a standard extension interface.
    # ------------------------------------------
    
    skip
  end
  
  it "works with or without a leading dot in the file extension" do
    skip
  end
end