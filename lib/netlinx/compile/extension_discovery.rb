module NetLinx
  module Compile
    # Discovers and auto-requires add-on Ruby libraries for netlinx-compile.
    class ExtensionDiscovery
      private_class_method :new
      
      class << self
        attr_accessor :extensions
        
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
          gems = Gem::Specification.all
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
          
          # Use ObjectSpace to find ExtensionHandler objects and call
          # their 'register' methods.
          handlers = ObjectSpace.each_object
            .select{|obj| obj.is_a? Class}
            .select{|obj| obj.name.eql? 'ExtensionHandler'}
          
          handlers.each {|handler| handler.register}
        end
        
      end
    end
  end
end