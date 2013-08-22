require 'test_helper'
require 'netlinx/source_file'
require 'test/netlinx/compilable'
require 'test/netlinx/compile/invokable'

describe NetLinx::SourceFile do
  include Test::NetLinx::Compilable
  include Test::NetLinx::Compile::Invokable
  
  before do
    @source_file = @object = NetLinx::SourceFile.new
  end
  
  after do
    @source_file = @object = nil
  end
  
  it "can auto-discover include files based on #include directives in the source file" do
    skip
  end
  
  it "can auto-discover module files based on define_module directives in the source file" do
    skip
  end
  
end