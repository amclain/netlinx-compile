require 'test_helper'
require 'netlinx/system'
require 'unit/compilable'
require 'ostruct'

describe NetLinx::System do
  include NetLinx::Compilable
  
  before do
    @system = @object = NetLinx::System.new
  end
  
  after do
    @system = @object = nil
  end
  
  describe "is compilable" do
    it "exposes one master source file as the target file to compile" do
      file = OpenStruct.new \
        type:           'MasterSrc',
        identifier:     'import-test',
        file_path_name: 'import-test.axs'
      
      @system << file
      @system.compiler_target_files.count.must_equal 1
      assert @system.compiler_target_files.include? \
        'import-test.axs'
    end
    
    it "lists .axi file paths under include paths" do
      file = OpenStruct.new \
        type:           'Include',
        identifier:     'import-include',
        file_path_name: 'include\import-include.axi'
      
      @system << file
      @system.compiler_include_paths.first.must_equal 'include\import-include.axi'
    end
    
    it "lists source, compiled, and duet modules under module paths" do
      source_module = OpenStruct.new \
        type:           'Module',
        identifier:     'test-module-source',
        file_path_name: 'module-source\test-module-source.axs'
        
      compiled_module = OpenStruct.new \
        type:           'TKO',
        identifier:     'test-module-compiled',
        file_path_name: 'module-compiled\test-module-compiled.tko'
        
      duet_module = OpenStruct.new \
        type:           'DUET',
        identifier:     'duet-lib-pjlink_dr0_1_1',
        file_path_name: 'duet-module\duet-lib-pjlink_dr0_1_1.jar'
      
      @system.compiler_module_paths.count.must_equal 0
      
      @system << source_module
      @system.compiler_module_paths.count.must_equal 1
      assert @system.compiler_module_paths.include? \
        'module-source\test-module-source.axs'
      
      @system << compiled_module
      @system.compiler_module_paths.count.must_equal 2
      assert @system.compiler_module_paths.include? \
        'module-compiled\test-module-compiled.tko'
      
      @system << duet_module
      @system.compiler_module_paths.count.must_equal 3
      assert @system.compiler_module_paths.include? \
        'duet-module\duet-lib-pjlink_dr0_1_1.jar'
    end
    
    it "returns an empty library path" do
      @system.compiler_library_paths.count.must_equal 0
    end
  end
  
  # TODO: This is a reminder for when the workspace features are transfered
  # to their own gem.
  describe "stores project data" do
    it "has an active state" do
      skip
    end
    
    it "has a platform (NetLinx/Axlink)" do
      skip
    end
    
    it "has an identifier (name)" do
      skip
    end
    
    it "has a system ID" do
      skip
    end
    
    it "has a connection method (specified as TransSerial, TransModem, TransTCPIP)" do
      skip
    end
    
    it "has a username parameter" do
      skip
    end
    
    it "has a password parameter" do
      skip
    end
    
    it "has an authentication enabled parameter" do
      skip
    end
    
    it "TODO: implement file grouping" do
      skip
    end
  end
  
  describe "xml output" do
    it "needs to be implemented" do
      skip
    end
  end
end