require 'netlinx/compile/script'

describe NetLinx::Compile::Script do
  
  subject { NetLinx::Compile::Script }
  
  let(:path) { 'spec/workspace/script' }
  
  
  it "is invoked by calling #run" do
    subject.should respond_to :run
  end
  
  it "is a singleton" do
    expect { NetLinx::Compile::Script.new }.to raise_error NoMethodError
  end
  
	it "selects and triggers an Invokable to compile itself based on file extension" do
    source = File.expand_path 'script.axs', path
    destination = File.expand_path 'script.tkn', path
    File.delete destination if File.exists? destination
    
    subject.run \
      argv: ['-s', source]
    
    File.exists?(destination).should eq true
	end
end