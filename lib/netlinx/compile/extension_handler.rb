module NetLinx
  module Compile
    # Tells netlinx-compile which class handles the compiling
    # of a set of file extensions.
    class ExtensionHandler
      # A list of file extensions that this ExtensionHandler handles.
      attr_accessor :extensions
      
      # A list of file extensions that this ExtensionHandler usurps.
      # For example, third-party workspace extensions would
      # probably usurp the .apw workspace extension.
      attr_accessor :usurps
      
      # The class to invoke to handle compiling a file extension specified
      # in this ExtensionHandler.
      attr_reader :handler_class
      
      # Parameters:
      #   extensions: An array of file extensions (without the leading dot)
      #               that this ExtensionHandler supports.
      #
      #   usurps:     Future.
      #               Lets this ExtensionHandler take priority over other
      #               ones. For example, most third-party handlers would
      #               probably usurp the .apw NetLinx Studio workspace
      #               extension.
      #
      #   is_a_workspace: Set to true if this ExtensionHandler is for
      #               compiling a workspace. False by default. This
      #               parameter assists with smart compiling, as
      #               ExtensionDiscovery can return all workspace_handlers.
      #
      #   handler_class: A reference to the class that should be instantiated
      #               if this handler is selected. For example,
      #               NetLinx::SourceFile is the class that handles files
      #               with the .axs extension.
      def initialize(**kvargs)
        @extensions     = kvargs.fetch :extensions,     []
        @usurps         = kvargs.fetch :usurps,         []
        @is_a_workspace = kvargs.fetch :is_a_workspace, false
        @handler_class  = kvargs.fetch :handler_class,  nil
      end
      
      # Alias to add a file extension.
      def <<(file_extension)
        @extensions << parse_extension(file_extension)
      end
      
      # Returns true if the ExtensionHandler handles a workspace file
      # (as opposed to a source code file).
      #
      # Workspace files are significant because they contain information
      # about a project, connection settings for a master, and possibly
      # multiple systems that need to be compiled. Therefore, when
      # smart-compiling, workspaces need to be distinguished from source
      # code files because discovering a workspace should be considered a
      # better match than discovering a source code file.
      def is_a_workspace?
        @is_a_workspace
      end
      
      # Returns true if this ExtensionHandler can handle the specified
      # file extension.
      def include?(file_extension)
        @extensions.include? parse_extension(file_extension)
      end
      
      private
      
      # Parse a file extension from the given string.
      #
      # Examples:
      #   apw
      #   .apw
      #   workspace.apw
      #   c:/path/to/workspace.apw
      def parse_extension(file_extension)
        ext = file_extension.scan(/(?:^\s*|(?<=\.))(\w+)$/).first
        raise ArgumentError, "Could not parse a file extension from the string: #{file_extension}" unless ext
        
        ext.first
      end
      
    end
  end
end