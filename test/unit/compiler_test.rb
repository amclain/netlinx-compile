require 'test_helper'
require 'netlinx/compiler'
require 'netlinx/compiler_result'
require 'test/netlinx/compilable'

# Generates source and compiled file paths and functions
# to aid in testing.
class TestFileGenerator
  attr_reader :source_file
  attr_reader :compiled_files
  
  # file_name can be specified with or without the .axs extension.
  def initialize(file_name, **kvargs)
    @path = 'test\unit\workspace\import-test'
    
    # Strip off file extension if it exists.
    file = file_name.gsub /\.axs$/, ''
    
    # Create the full source file path.
    @source_file = "#{File.expand_path file, @path}.axs"
    
    # Create the full compiled file paths.
    @compiled_files = ['.tko', '.tkn']
      .map {|extension| @source_file.gsub(/\.axs$/, extension)}
  end
end
  
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

describe MockCompilable do
  include Test::NetLinx::Compilable
  
  before do
    @compilable = @object = MockCompilable.new
  end
  
  after do
    @compilable = @object = nil
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
    }.must_raise NetLinx::NoCompilerError
  end
  
  it "compiles a .axs source code file" do
    files = TestFileGenerator.new 'source-file-plain'
    
    files.compiled_files.each do |file|
      # Delete any existing files.
      File.delete file if File.exists? file
      
      # Compiled files should not exist.
      assert_equal false, File.exists?(file)
    end
    
    # Add source code file to the list of targets to compile.
    @compilable.compiler_target_files << files.source_file
    
    # Run the compiler.
    @compiler.compile @compilable
    
    # Compiled files should exist.
    files.compiled_files.each do |file|
      assert_equal true, File.exists?(file)
    end
  end
  
  it "compiles a source code file with an include" do
    files = TestFileGenerator.new 'source-file-include'
    
    files.compiled_files.each do |file|
      # Delete any existing files.
      File.delete file if File.exists? file
      
      # Compiled files should not exist.
      assert_equal false, File.exists?(file)
    end
    
    # Add source code file to the list of targets to compile.
    @compilable.compiler_target_files << files.source_file
    @compilable.compiler_include_paths <<
      File.expand_path('include', @path)
    
    # Run the compiler.
    @compiler.compile @compilable
    
    # Compiled files should exist.
    files.compiled_files.each do |file|
      assert_equal true, File.exists?(file)
    end
  end
  
  it "compiles a source code file with a module" do
    files = TestFileGenerator.new 'source-file-module'
    
    files.compiled_files.each do |file|
      # Delete any existing files.
      File.delete file if File.exists? file
      
      # Compiled files should not exist.
      assert_equal false, File.exists?(file)
    end
    
    # Add source code file to the list of targets to compile.
    @compilable.compiler_target_files << files.source_file
    @compilable.compiler_module_paths <<
      File.expand_path('module-compiled', @path)
    
    # Run the compiler.
    @compiler.compile @compilable
    
    # Compiled files should exist.
    files.compiled_files.each do |file|
      assert_equal true, File.exists?(file)
    end
  end
  
  it "compiles a source code file with a library" do
    skip
  end
  
  it "returns a hash of source file, compiler result, and compiler output for each source file" do
    f1 = TestFileGenerator.new 'compiler-result1'
    f2 = TestFileGenerator.new 'compiler-result2'
    
    source_files = [f1.source_file, f2.source_file]
    compiled_files = f1.compiled_files + f2.compiled_files
    
    compiled_files.each do |file|
      # Delete any existing files.
      File.delete file if File.exists? file
      
      # Compiled files should not exist.
      assert_equal false, File.exists?(file)
    end
    
    # Add source code file to the list of targets to compile.
    @compilable.compiler_target_files += source_files
    
    # Run the compiler.
    result = @compiler.compile @compilable
    
    # Compiled files should exist.
    compiled_files.each do |file|
      assert_equal true, File.exists?(file)
    end
    
    # Compiler result should be an array of CompilerResult.
    assert result.is_a? Array
    assert result.first.is_a? NetLinx::CompilerResult
    
    result.count.must_equal 2
    
    first = result.first
    first.target_file.must_equal            f1.source_file
    first.compiler_include_paths.must_equal []
    first.compiler_module_paths.must_equal  []
    first.compiler_library_paths.must_equal []
    first.errors.must_equal                 0
    first.warnings.must_equal               0
    assert first.success?
    assert first.stream.include? 'NetLinx Compile Complete'
  end
  
  it "returns a failure result when compiling a nonexistent file" do
    file = TestFileGenerator.new 'this-file-does-not-exist'
    
    # The nonexistent file should not exist.
    assert_equal false, File.exists?(file.source_file)
    
    # Add source code file to the list of targets to compile.
    @compilable.compiler_target_files << file.source_file
    
    # Run the compiler.
    result = @compiler.compile(@compilable).first
    
    # Compiler should return an error.
    result.success?.must_equal false
    result.errors.must_equal   nil
    result.warnings.must_equal nil
  end
  
  it "returns the correct number of errors and warnings when compiling" do
    file = TestFileGenerator.new 'compiler-errors'
    
    # Add source code file to the list of targets to compile.
    @compilable.compiler_target_files << file.source_file
    
    # Run the compiler.
    result = @compiler.compile(@compilable).first
    
    # Compiler should return 2 warnings and 1 error.
    result.warnings.must_equal 2
    result.errors.must_equal   1
  end
end