module Test::NetLinx::Compile
  # Interface tests for an object that provides a means to
  # compile a Compilable file extension.
  # See ExtensionDiscovery.
  class Extendable
    def test_responds_to_...
      assert_respond_to @object, :method_name
    end
  end
end