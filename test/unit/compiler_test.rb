require 'test_helper'
require 'netlinx/compiler'
require 'ostruct'

class MockCompilable
  attr_accessor :compiler_target_files
  attr_accessor :compiler_include_paths
  attr_accessor :compiler_module_paths
  attr_accessor :compiler_library_paths
  
  def initialize
    @compiler_target_files  = []
    @compiler_include_paths = []
    @compiler_module_paths  = []
    @compiler_library_paths = []
  end
end

describe NetLinx::Compiler do
  before do
    @path = 'test\unit\workspace\import-test'
    @compiler = @object = NetLinx::Compiler.new
    @compilable = MockCompilable.new
  end
  
  after do
    @compiler = @object = nil
  end
  
  it "raises an exception if the compiler cannot be found" do
    Proc.new {
      NetLinx::Compiler.new(compiler_path: 'c:\this-path-does-not-exist')
    }.must_raise NoCompilerError
  end
  
  it "compiles a .axs source code file" do
    source_file = File.expand_path 'module-source/test-module-source.axs', @path
    
    compiled_files = ['.tko', '.tkn']
      .map {|extension| source_file.gsub(/\.axs$/, extension)}
    
    compiled_files.each do |file|
      # Delete any existing files.
      File.delete file if File.exists? file
      
      # Compiled files should not exist.
      assert_equal false, File.exists?(file)
    end
    
    # Add source code file to the list of targets to compile.
    @compilable.compiler_target_files << source_file
    
    # Run the compiler.
    @compiler.compile @compilable
    
    # Compiled files should exist.
    compiled_files.each do |file|
      assert_equal true, File.exists?(file)
    end
  end
end