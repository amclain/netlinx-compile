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
    end
    
    # Alias to add a system.
    def <<(system)
      @systems << system
    end
    
    # Returns the project name.
    def to_s
      @name
    end
    
  end
end