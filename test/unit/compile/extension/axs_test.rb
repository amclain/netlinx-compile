require 'test_helper'
require 'netlinx/compile/extension/axs'
require 'test/netlinx/compile/invokable'

describe NetLinx::Compile::Extension::AXS do
  include Test::NetLinx::Compile::Invokable
  
  before do
    @axs = @object = NetLinx::Compile::Extension::AXS.new
  end
  
  after do
    @axs = @object = nil
  end
  
  it "invokes the compiler for a file with the .axs extension" do
    skip
  end
end