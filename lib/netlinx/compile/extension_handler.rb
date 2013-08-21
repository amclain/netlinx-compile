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
      
      
      def initialize(**kvargs)
        @extensions    = kvargs.fetch :extensions, []
        @usurps        = kvargs.fetch :usurps, []
        @handler_class = kvargs.fetch :handler_class, nil
      end
      
      # Alias to add a file extension.
      def <<(file_extension)
        @extensions << parse_extension(file_extension)
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