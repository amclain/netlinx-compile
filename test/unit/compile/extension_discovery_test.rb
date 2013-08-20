require 'test_helper'
require 'netlinx/compile/extension_discovery'

describe NetLinx::Compile::ExtensionDiscovery do
  
  # NOTE:
  # Some of this logic is difficult to test without creating and installing
  # a mock gem. The problem with a mock gem is that it's bulky and makes for
  # very slow testing (has to be installed each rake). Since the compiler
  # tests already assert the result of compiling AXS source files, a built-in
  # extension, it is more efficient to take some of the discovery process on
  # faith because the AXS test will show if it's working correctly.
  
  before do
    @extension_discovery = @object = NetLinx::Compile::ExtensionDiscovery
  end
  
  after do
    @extension_discovery = @object = nil
  end
  
  it "is a singleton" do
    Proc.new {
      NetLinx::Compile::ExtensionDiscovery.new
    }.must_raise NoMethodError
  end
  
  it "responds to discover" do
    assert_respond_to @extension_discovery, :discover
  end
  
  it "runs discover without raising an exception" do
    @extension_discovery.discover
    assert true
  end
  
end