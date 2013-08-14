require 'test_helper'
require 'netlinx/project'

describe NetLinx::Project do
  
  before do
    @project = @object = NetLinx::Project.new
  end
  
  after do
    @project = @object = nil
  end
  
  it "has a name" do
    name = 'import-test-project'
    @project.name = name
    @project.name.must_equal name
  end
  
  it "has a dealer" do
    dealer = 'Test Dealer'
    @project.dealer = dealer
    @project.dealer.must_equal dealer
  end
  
  it "has a designer" do
    designer = 'Test Designer'
    @project.designer = designer
    @project.designer.must_equal designer
  end
  
  it "has a sales order field" do
    sales_order = 'Test Sales Order'
    @project.sales_order = sales_order
    @project.sales_order.must_equal sales_order
  end
  
  it "has a purchase order field" do
    purchase_order = 'Test Purchase Order'
    @project.purchase_order = purchase_order
    @project.purchase_order.must_equal purchase_order
  end
  
  it "has a description" do
    description = 'Test Description'
    @project.description = description
    @project.description.must_equal description
  end
  
  it "contains systems" do
    @project.systems.must_equal []
  end
  
  it "prints its name for to_s" do
    name = 'project name'
    @project.name = name
    @project.to_s.must_equal name
  end
  
  it "can add a system with <<" do
    system = NetLinx::System.new
    @project << system
    @project.systems.first.must_equal system
  end
  
end