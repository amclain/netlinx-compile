require 'test_helper'
require 'netlinx/source_file'
require 'test/netlinx/compilable'

describe NetLinx::SourceFile do
  include Test::NetLinx::Compilable
  
  before do
    @source_file = @object = NetLinx::SourceFile.new
  end
  
  after do
    @source_file = @object = nil
  end
  
  it "does something" do
    skip
  end
end