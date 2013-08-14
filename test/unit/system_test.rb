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
        type: 'MasterSrc',
        name: 'import-test',
        path: 'import-test.axs'
      
      @system << file
      @system.compiler_target_files.count.must_equal 1
      assert @system.compiler_target_files.include? \
        'import-test.axs'
    end
    
    it "lists .axi file paths under include paths" do
      file = OpenStruct.new \
        type: 'Include',
        name: 'import-include',
        path: 'include\import-include.axi'
      
      @system << file
      @system.compiler_include_paths.first.must_equal 'include\import-include.axi'
    end
    
    it "lists source, compiled, and duet modules under module paths" do
      source_module = OpenStruct.new \
        type: 'Module',
        name: 'test-module-source',
        path: 'module-source\test-module-source.axs'
        
      compiled_module = OpenStruct.new \
        type: 'TKO',
        name: 'test-module-compiled',
        path: 'module-compiled\test-module-compiled.tko'
        
      duet_module = OpenStruct.new \
        type: 'DUET',
        name: 'duet-lib-pjlink_dr0_1_1',
        path: 'duet-module\duet-lib-pjlink_dr0_1_1.jar'
      
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
  
  describe "stores project data" do
    it "has a name" do
      name = 'import-test-system'
      @system.name = name
      @system.name.must_equal name
    end
    
    it "has a system ID" do
      id = 5
      @system.id = id
      @system.id.must_equal id
    end
    
    it "has a description" do
      description = 'Test system description.'
      @system.description = description
      @system.description.must_equal description
    end
    
    it "has files" do
      @system.files.must_equal []
    end
    
    it "has communication settings" do
      skip
    end
  end
  
  it "outputs its name for to_s" do
    name = 'system name'
    @system.name = name
    @system.to_s.must_equal name
  end
  
  it "can add a file with <<" do
    f = OpenStruct.new
    @system << f
    @system.files.first.must_equal f
  end
  
  describe "xml output" do
    it "needs to be implemented" do
      skip
    end
  end
end