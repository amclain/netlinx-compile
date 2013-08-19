module Test
  module NetLinx
    module Compile
      # Interface tests for an object that provides a means to
      # invoke the compiler on a Compilable file extension.
      # See ExtensionDiscovery.
      module Invokable
        def test_responds_to_invoke_compile
          assert_respond_to @object, :invoke_compile
        end
      end
    end
  end
end