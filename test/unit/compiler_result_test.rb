require 'test_helper'
require 'netlinx/compiler_result'
require 'netlinx/test/compilable'

describe NetLinx::CompilerResult do
  include NetLinx::Test::Compilable
  
  before do
    @compiler_result = @object = NetLinx::CompilerResult.new
  end
  
  after do
    @compiler_result = @object = nil
  end
  
  it "contains the stream of text printed by the compiler" do
    assert_respond_to @compiler_result, :stream
  end
  
  it "contains the target file that was compiled" do
    assert_respond_to @compiler_result, :target_file
  end
  
  it "contains a compiler success property" do
    assert_respond_to @compiler_result, :success?
  end
  
  it "contains the number of errors returned by the compiler" do
    assert_respond_to @compiler_result, :errors
  end
  
  it "contains the number of warnings returned by the compiler" do
    assert_respond_to @compiler_result, :warnings
  end
  
end