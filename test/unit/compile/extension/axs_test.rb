require 'test_helper'
require 'netlinx/compile/extension/axs'
require 'test/netlinx/compile/discoverable'

describe NetLinx::Compile::Extension::AXS do
  include Test::NetLinx::Compile::Discoverable
  
  before do
    @path = 'test\unit\workspace\extension\axs'
    @axs = @object = NetLinx::Compile::Extension::AXS
  end
  
  after do
    @axs = @object = nil
  end
  
  it "handles .axs and .axi NetLinx source code files" do
    @axs.get_handler.extensions.include?('axs').must_equal true
    @axs.get_handler.extensions.include?('axi').must_equal true
    
    @axs.get_handler.handler_class.must_equal NetLinx::SourceFile
  end
end