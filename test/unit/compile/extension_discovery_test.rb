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
    
    @extension_discovery.load_handler('.axs').must_equal true
  end
  
  it "works with or without a leading dot in the file extension" do
    @extension_discovery.load_handler('.axs').must_equal true
    @extension_discovery.load_handler('axs').must_equal true
  end
  
  it "works if the file name/path is entered instead of the extension" do
    @extension_discovery.load_handler('my_file.axs').must_equal true
    @extension_discovery.load_handler('c:/path/to/my_file.axs').must_equal true
  end
  
  it "raises LoadError if a library is not available for the extension specified" do
    Proc.new {
      @extension_discovery.load_handler('.invalid_extension')
    }.must_raise LoadError
  end
  
  it "raises ArgumentError if invalid data is given" do
    Proc.new {
      @extension_discovery.load_handler('')
    }.must_raise ArgumentError
  end
end