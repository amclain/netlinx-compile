module NetLinx
  module Compile
    # Discovers and auto-requires add-on Ruby libraries for netlinx-compile
    # based on a file extension.
    class ExtensionDiscovery
      private_class_method :new
      
      class << self
        
        # Searches for gems with 'netlinx-compile' as a dependency.
        # The 'lib/netlinx/compile/extension/*' path is checked for
        # compiler extensions.
        def discover
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
        end
        
      end
    end
  end
end