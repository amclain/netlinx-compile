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
  
  it "returns an array of error and warning lines" do
    @compiler_result = NetLinx::CompilerResult.new \
      stream: <<-EOS
---- Starting NetLinx Compile - Version[2.5.2.20] [08-15-2013 20:13:09] ----
WARNING: M:/AMX/Libraries/netlinx-compile/test/unit/workspace/import-test/compiler-errors.axs(45): C10571: Converting type [INTEGER] to [CHAR]
WARNING: M:/AMX/Libraries/netlinx-compile/test/unit/workspace/import-test/compiler-errors.axs(46): C10571: Converting type [INTEGER] to [CHAR]
ERROR: M:/AMX/Libraries/netlinx-compile/test/unit/workspace/import-test/compiler-errors.axs(48): C10515: Cannot find function definition for [FUNCTION_DOES_NOT_EXIST], check case sensitivity

M:/AMX/Libraries/netlinx-compile/test/unit/workspace/import-test/compiler-errors.axs - 1 error(s), 2 warning(s)

NetLinx Compile Complete [08-15-2013 20:13:09] ----------
EOS
    
    @compiler_result.warnings.must_equal 2
    @compiler_result.errors.must_equal   1
    
    @compiler_result.warning_items.count.must_equal 2
    @compiler_result.error_items.count.must_equal   1
    
    @compiler_result.warning_items.first.must_equal \
      "WARNING: M:/AMX/Libraries/netlinx-compile/test/unit/workspace/import-test/compiler-errors.axs(45): C10571: Converting type [INTEGER] to [CHAR]"
      
    @compiler_result.error_items.first.must_equal \
      "ERROR: M:/AMX/Libraries/netlinx-compile/test/unit/workspace/import-test/compiler-errors.axs(48): C10515: Cannot find function definition for [FUNCTION_DOES_NOT_EXIST], check case sensitivity"
  end
  
  it "returns empty arrays for error and warning lines when they don't exist" do
    @compiler_result = NetLinx::CompilerResult.new \
      stream: <<-EOS
---- Starting NetLinx Compile - Version[2.5.2.20] [08-15-2013 20:40:57] ----

M:/AMX/Libraries/netlinx-compile/test/unit/workspace/import-test/compiler-result
1.axs - 0 error(s), 0 warning(s)
Compiled Code takes 8391 bytes of memory

NetLinx Compile Complete [08-15-2013 20:40:57] ----------
EOS
    
    @compiler_result.warnings.must_equal 0
    @compiler_result.errors.must_equal   0
    
    @compiler_result.warning_items.count.must_equal 0
    @compiler_result.error_items.count.must_equal   0
    
  end
  
end