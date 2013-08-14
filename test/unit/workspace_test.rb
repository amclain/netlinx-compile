require 'test_helper'
require 'netlinx/workspace'

describe NetLinx::Workspace do
  
  before do
    @workspace = @object = NetLinx::Workspace.new
    @workspace_path = 'test/unit/workspace/import-test'
  end
  
  after do
    @workspace = @object = nil
  end
  
  it "has a name" do
    name = 'my workspace'
    @workspace.name = name
    @workspace.name.must_equal name
  end
  
  it "has a description" do
    description = 'test description'
    @workspace.description = description
    @workspace.description.must_equal description
  end
  
  it "contains projects" do
    @workspace.projects.must_equal []
  end
  
  it "can be initialized from a .axw file" do
    # Import the test project.
    @workspace = NetLinx::Workspace.new \
      file: File.expand_path('import-test.apw', @workspace_path)
      
    @workspace.name.must_equal    'import-test'
    @workspace.description.must_equal 'For testing Ruby import.'
    
    # Check project data.
    @workspace.projects.count.must_equal 1
    project = @workspace.projects.first
    
    project.name.must_equal           'import-test-project'
    project.dealer.must_equal         'Test Dealer'
    project.designer.must_equal       'Test Designer'
    project.sales_order.must_equal    'Test Sales Order'
    project.purchase_order.must_equal 'Test PO'
    project.description.must_equal    'Test project description.'
    
    # Check system data.
    @project.systems.count.must_equal 1
    system = project.systems.first
    
    system.name.must_equal        'import-test-system'
    system.id.must_equal          0
    system.description.must_equal 'Test system description.'
    
    # Contains the MasterSrc file to be compiled.
    assert system.compiler_target_files.include?(
      File.expand_path('import-test.axs', @workspace_path)
      ), "Contains the MasterSrc file to be compiled."
    
    # Contains include paths.
    assert system.compiler_include_paths.include?(
      File.expand_path('include', @workspace_path)
      ), "Contains source code include path."
    
    # Contains module paths.
    assert system.compiler_module_paths.include?(
      File.expand_path('duet-module', @workspace_path)
      ), "Contains duet module path."
    
    assert system.compiler_module_paths.include?(
      File.expand_path('module-compiled', @workspace_path)
      ), "Contains compiled module path."
    
    assert system.compiler_module_paths.include?(
      File.expand_path('module-source', @workspace_path)
      ), "Contains source code module path."
  end
  
  # TODO:
  # Iterate projects in a workspace,
  # iterate systems in each project,
  # build each system.
  #
  # Each system will actually be a Compilable, not the
  # whole workspace. Actually, the whole workspace is
  # a collection of Compilables.
  #
  # The NetLinx system (inside workspace) is actually what
  # contains the structure of the project's files and master
  # info. Workspace is just a container of projects/systems.
  
end