require 'netlinx/system'

module NetLinx
  # A collection of NeTLinx systems.
  # Workspace -> Project -> System
  class Project
    attr_accessor :name
    attr_accessor :description
    attr_accessor :dealer
    attr_accessor :designer
    attr_accessor :sales_order
    attr_accessor :purchase_order
    attr_accessor :systems
    
    def initialize(**kvargs)
      @name           = kvargs.fetch :name,           ''
      @description    = kvargs.fetch :description,    ''
      @dealer         = kvargs.fetch :dealer,         ''
      @designer       = kvargs.fetch :designer,       ''
      @sales_order    = kvargs.fetch :sales_order,    ''
      @purchase_order = kvargs.fetch :purchase_order, ''
      
      @systems = []
      
      project_element = kvargs.fetch :element, nil
      parse_xml_element project_element if project_element
    end
    
    # Alias to add a system.
    def <<(system)
      @systems << system
    end
    
    # Returns the project name.
    def to_s
      @name
    end
    
    private
    
    def parse_xml_element(project)
      # Load project params.
      # TODO: Curly braces don't work with each_element. p247 bug? 
      project.each_element 'Identifier' do |e| @name = e.text.strip end
      project.each_element 'Designer' do |e| @designer = e.text.strip end
      project.each_element 'DealerID' do |e| @dealer = e.text.strip end
      project.each_element 'SalesOrder' do |e| @sales_order = e.text.strip end
      project.each_element 'PurchaseOrder' do |e| @purchase_order = e.text.strip end
      project.each_element 'Comments' do |e| @description = e.text end
        
      # Load systems.
      project.each_element 'System' do |e|
        system = NetLinx::System.new element: e
        @systems << system
      end
    end
    
  end
end