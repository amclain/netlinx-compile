module NetLinx
  module Compile
    # Discovers and auto-requires add-on Ruby libraries for netlinx-compile.
    class ExtensionDiscovery
      private_class_method :new
      
      class << self
        # An array of ExtensionHandlers installed on the system.
        # #discover must be run before this array is populated.
        attr_accessor :handlers
        
        @handlers = []
        
        # Searches for gems with 'netlinx-compile' as a dependency.
        # The 'lib/netlinx/compile/extension/*' path is checked for
        # compiler extensions.
        def discover
          # Require extensions built into netlinx-compile.
          nc_gem = Gem::Specification.find_by_name 'netlinx-compile'
          nc_gem_path = File.expand_path 'lib/netlinx/compile/extension', nc_gem.gem_dir
          nc_gem_files = Dir["#{nc_gem_path}/*.rb"]
          nc_gem_files.each {|file| require file}
          
          # Find gems with a dependency on 'netlinx-compile'.
          gems = Gem::Specification.each
            .select{|gem| gem.dependencies
              .select{|dependency| dependency.name == 'netlinx-compile'}
              .empty? == false
            }
          
          # Load any Ruby files in their lib/netlinx/compile/extension paths.
          gems.each do |gem|
            extension_path = File.expand_path 'lib/netlinx/compile/extension', gem.gem_dir
            files = Dir["#{extension_path}/*.rb"]
            files.each {|file| require file}
          end
          
          # Register ExtensionHandler objects.
          @handlers = NetLinx::Compile::Extension.constants
            .map{|c| NetLinx::Compile::Extension.const_get c}
            .select{|c| c.is_a? Class}
            .map{|c| c.get_handler if c.respond_to? :get_handler}
            .select{|c| not c.nil?}
        end
        
        # Returns an array of workspace file extensions.
        def workspace_extensions
          @handlers
            .select{|h| h.is_a_workspace?}
            .map{|h| h.extensions}
            .flatten
        end
        
        # Get an ExtensionHandler for a given file or extension.
        def get_handler(filename)
          @handlers.select{|h| h.include? filename}.first
        end
        
      end
    end
  end
end