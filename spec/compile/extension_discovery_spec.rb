require 'netlinx/compile/extension_discovery'

describe NetLinx::Compile::ExtensionDiscovery do
  
  # NOTE:
  # Some of this logic is difficult to test without creating and installing
  # a mock gem. The problem with a mock gem is that it's bulky and makes for
  # very slow testing (has to be installed each rake). Since the compiler
  # tests already assert the result of compiling AXS source files, a built-in
  # extension, it is more efficient to take some of the discovery process on
  # faith because the AXS test will show if it's working correctly.
  
  subject { NetLinx::Compile::ExtensionDiscovery }
  
  
  it { should respond_to :discover }
  
  it "is a singleton" do
    expect { NetLinx::Compile::ExtensionDiscovery.new }.to raise_error NoMethodError
  end
  
  it "runs discover without raising an exception" do
    subject.discover
  end
  
  it "returns a handler for a given file or file extension" do
    subject.discover
    subject.get_handler('axs')
      .is_a?(NetLinx::Compile::ExtensionHandler)
      .should eq true
  end
  
  it "returns an array of workspace handlers" do
    pending
    # NOTE: netlinx-workspace gem must be installed for this to pass.
    # TODO: Stub it.
    subject.discover
    subject.workspace_extensions.include?('apw').should eq true
  end
  
end