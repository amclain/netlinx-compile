require 'netlinx/compiler_result'
require 'test/netlinx/compilable'

describe NetLinx::CompilerResult do
  
  include_examples "compilable"
  
  it "contains the stream of text printed by the compiler" do
    subject.should respond_to :stream
  end
  
  it "contains the target file that was compiled" do
    subject.should respond_to :target_file
  end
  
  it "contains a compiler success property" do
    subject.should respond_to :success?
  end
  
  it "contains the number of errors returned by the compiler" do
    subject.should respond_to :errors
  end
  
  it "contains the number of warnings returned by the compiler" do
    subject.should respond_to :warnings
  end
  
  it "returns @stream when to_s is called" do
    stream = 'it works'
    subject = NetLinx::CompilerResult.new \
      stream: stream
    
    subject.to_s.should eq stream
  end
  
  it "returns an array of error and warning lines" do
    subject = NetLinx::CompilerResult.new \
      stream: <<-EOS
---- Starting NetLinx Compile - Version[2.5.2.20] [08-15-2013 20:13:09] ----
WARNING: M:/AMX/Libraries/netlinx-compile/test/unit/workspace/import-test/compiler-errors.axs(45): C10571: Converting type [INTEGER] to [CHAR]
WARNING: M:/AMX/Libraries/netlinx-compile/test/unit/workspace/import-test/compiler-errors.axs(46): C10571: Converting type [INTEGER] to [CHAR]
ERROR: M:/AMX/Libraries/netlinx-compile/test/unit/workspace/import-test/compiler-errors.axs(48): C10515: Cannot find function definition for [FUNCTION_DOES_NOT_EXIST], check case sensitivity

M:/AMX/Libraries/netlinx-compile/test/unit/workspace/import-test/compiler-errors.axs - 1 error(s), 2 warning(s)

NetLinx Compile Complete [08-15-2013 20:13:09] ----------
EOS
    
    subject.warnings.should eq 2
    subject.errors.should eq   1
    
    subject.warning_items.count.should eq 2
    subject.error_items.count.should eq   1
    
    subject.warning_items.first.should eq \
      "WARNING: M:/AMX/Libraries/netlinx-compile/test/unit/workspace/import-test/compiler-errors.axs(45): C10571: Converting type [INTEGER] to [CHAR]"
      
    subject.error_items.first.should eq \
      "ERROR: M:/AMX/Libraries/netlinx-compile/test/unit/workspace/import-test/compiler-errors.axs(48): C10515: Cannot find function definition for [FUNCTION_DOES_NOT_EXIST], check case sensitivity"
  end
  
  it "returns empty arrays for error and warning lines when they don't exist" do
    subject = NetLinx::CompilerResult.new \
      stream: <<-EOS
---- Starting NetLinx Compile - Version[2.5.2.20] [08-15-2013 20:40:57] ----

M:/AMX/Libraries/netlinx-compile/test/unit/workspace/import-test/compiler-result
1.axs - 0 error(s), 0 warning(s)
Compiled Code takes 8391 bytes of memory

NetLinx Compile Complete [08-15-2013 20:40:57] ----------
EOS
    
    subject.warnings.should eq 0
    subject.errors.should eq   0
    
    subject.warning_items.count.should eq 0
    subject.error_items.count.should eq   0
    
  end
  
end