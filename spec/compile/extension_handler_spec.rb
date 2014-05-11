require 'netlinx/compile/extension_handler'

describe NetLinx::Compile::ExtensionHandler do
  
  before do
    @extension_handler = @object = NetLinx::Compile::ExtensionHandler.new
  end
  
  after do
    @extension_handler = @object = nil
  end
  
  it "exposes a set of extensions that it can handle" do
    assert_respond_to @extension_handler, :extensions
    
    # Implements array methods.
    @extension_handler.extensions.count.must_equal 0
    @extension_handler.extensions.first.must_equal nil
  end
  
  it "exposes a set of extensions it usurps" do
    # For example, third-party workspace extensions would
    # probably usurp the .apw workspace extension.
    
    assert_respond_to @extension_handler, :usurps
    
    # Implements array methods.
    @extension_handler.extensions.count.must_equal 0
    @extension_handler.extensions.first.must_equal nil
  end
  
  it "exposes if it is a workspace" do
    @extension_handler.is_a_workspace?.must_equal false
  end
  
  it "can check to see if it includes a given extension" do
    assert_respond_to @extension_handler, :include?
    
    @extension_handler.extensions << 'apw'
    @extension_handler.include?('.apw').must_equal true
    @extension_handler.include?('.axs').must_equal false
    
    Proc.new {
      @extension_handler.include?('invalid extension')
    }.must_raise ArgumentError
  end
    
  it "exposes a class to handle its extensions" do
    assert_respond_to @extension_handler, :handler_class
  end
  
  it "defines << operator as an alias to add an extension" do
    assert_respond_to @extension_handler, :<<
    
    @extension_handler << 'apw'
    @extension_handler.extensions.include?('apw').must_equal true
  end
end