require 'test_helper'
require 'netlinx/compile/extension/axs'
require 'test/netlinx/compile/invokable'

describe NetLinx::Compile::Extension::AXS do
  include Test::NetLinx::Compile::Invokable
  
  before do
    @path = 'test\unit\workspace\extension\axs'
    @axs = @object = NetLinx::Compile::Extension::AXS.new
  end
  
  after do
    @axs = @object = nil
  end
  
  it "invokes the compiler for a file with the .axs extension" do
    source = File.expand_path 'axs-file.axs', @path
    destination = File.expand_path 'axs-file.tkn', @path
    File.delete destination if File.exists? destination
    
    @axs.invoke_compile target: source
    
    File.exists?(destination).must_equal true
  end
  
  it "raises ArgumentError if the target is not specified" do
    Proc.new {
      @axs.invoke_compile
    }.must_raise ArgumentError
  end
  
  it "returns a compiler result" do
    source = File.expand_path 'axs-file.axs', @path
    
    @axs.invoke_compile(target: source).first
      .is_a?(NetLinx::CompilerResult).must_equal true
  end
end