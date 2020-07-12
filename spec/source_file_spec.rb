require 'netlinx/source_file'
require 'test/netlinx/compilable'
require 'test/netlinx/compile/invokable'

describe NetLinx::SourceFile do
  
  let(:path) { 'spec/workspace/import-test' }
  
  
  include_examples "compilable"
  
  include_examples "invokable"
  
  it "correctly determines encoding for an ASCII file opened as UTF-8" do
    # Note: This error is caused by setting the option "Use UTF-8 as default
    # external encoding" when installing Ruby. NetLinx Studio encodes files as
    # Windows 1252 with invalid UTF-8 bytes in the default file template, which
    # then causes an encoding issue when Ruby trys to ingest the file as UTF-8.
    
    File.should_receive :open do
      Object.new.tap do |object|
        object.define_singleton_method :read do
          "invalid UTF-8 \255"
        end
      end
    end
    
    subject = NetLinx::SourceFile.new file: 'anything'
  end
  
  it "can auto-discover include files based on #include directives in the source file" do
    file = File.expand_path 'source-file-include.axs', path
    subject = NetLinx::SourceFile.new file: file
    
    subject.compiler_include_paths
      .include?(File.expand_path 'include', path)
      .should eq true
  end
  
  it "can auto-discover module files based on define_module directives in the source file" do
    file = File.expand_path 'source-file-module.axs', path
    subject = NetLinx::SourceFile.new file: file
    
    subject.compiler_module_paths
      .include?(File.expand_path 'module-compiled', path)
      .should eq true
  end
  
  xit "recurses through included files to find additional paths" do
    # ------------------------------------------------------------------
    # TODO: Include/module path search needs to recurse through the
    #       files that are discovered.
    #
    # Example: In the current system, if a source file includes a .axi
    # that includes a Duet module .jar, the build fails because the path
    # to the .jar file is not found.
    # ------------------------------------------------------------------
      
    pending
  end
  
end