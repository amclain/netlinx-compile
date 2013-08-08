require 'test_helper'
require 'netlinx-compiler'

describe NetLinxCompiler do
  it "raises an exception if the compiler cannot be found" do
    Proc.new {
      NetLinxCompiler.new(compiler_path: 'c:\this-path-does-not-exist')
    }.must_raise NoCompilerError
  end
end