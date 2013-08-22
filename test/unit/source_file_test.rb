require 'test_helper'
require 'netlinx/source_file'
require 'test/netlinx/compilable'
require 'test/netlinx/compile/invokable'

describe NetLinx::SourceFile do
  include Test::NetLinx::Compilable
  include Test::NetLinx::Compile::Invokable
  
  before do
    @path = 'test\unit\workspace\import-test'
    @source_file = @object = NetLinx::SourceFile.new
  end
  
  after do
    @source_file = @object = nil
  end
  
  it "can auto-discover include files based on #include directives in the source file" do
    file = File.extend_path 'source-file-include.axs', @path
    @source_file = NetLinx::SourceFile.new file: file
    
    @source_file.compiler_include_paths
      .include?(File.extend_path 'include', @path)
      .must_equal true
  end
  
  it "can auto-discover module files based on define_module directives in the source file" do
    file = File.extend_path 'source-file-module.axs', @path
    @source_file = NetLinx::SourceFile.new file: file
    
    @source_file.compiler_include_paths
      .include?(File.extend_path 'module-compiled', @path)
      .must_equal true
  end
  
end