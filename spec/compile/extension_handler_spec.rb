require 'netlinx/compile/extension_handler'

describe NetLinx::Compile::ExtensionHandler do
  
  it "exposes a set of extensions that it can handle" do
    subject.should respond_to :extensions
    
    # Implements array methods.
    subject.extensions.count.should be 0
    subject.extensions.first.should be nil
  end
  
  it "exposes a set of extensions it usurps" do
    # For example, third-party workspace extensions would
    # probably usurp the .apw workspace extension.
    
    subject.should respond_to :usurps
    
    # Implements array methods.
    subject.extensions.count.should be 0
    subject.extensions.first.should be nil
  end
  
  it "exposes if it is a workspace" do
    subject.is_a_workspace?.should be false
  end
  
  it "can check to see if it includes a given extension" do
    subject.should respond_to :include?
    
    subject.extensions << 'apw'
    subject.include?('.apw').should be true
    subject.include?('.axs').should be false
    
    expect { subject.include?('invalid extension') }.to raise_error ArgumentError
  end
    
  it "exposes a class to handle its extensions" do
    subject.should respond_to :handler_class
  end
  
  it "defines << operator as an alias to add an extension" do
    subject.should respond_to :<<
    
    subject << 'apw'
    subject.extensions.include?('apw').should be true
  end
end