require 'netlinx/compile/extension/axs'
require 'test/netlinx/compile/discoverable'

describe NetLinx::Compile::Extension::AXS do
  
  subject { NetLinx::Compile::Extension::AXS }
  
  let(:path) { 'test/unit/workspace/extension/axs' }
  
  
  include_examples "discoverable"
  
  it "handles .axs and .axi NetLinx source code files" do
    subject.get_handler.extensions.include?('axs').should eq true
    subject.get_handler.extensions.include?('axi').should eq true
    
    subject.get_handler.handler_class.should eq NetLinx::SourceFile
  end
  
end