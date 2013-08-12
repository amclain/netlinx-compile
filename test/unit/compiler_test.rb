require 'test_helper'
require 'netlinx-compile/compiler'

describe NetLinx::Compiler do
  it "raises an exception if the compiler cannot be found" do
    Proc.new {
      NetLinx::Compiler.new(compiler_path: 'c:\this-path-does-not-exist')
    }.must_raise NoCompilerError
  end
end