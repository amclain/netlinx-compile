module Test
  module NetLinx
    module Compile
      # Interface tests for an object that registers an EventHandler
      # under NetLinx::Compile::Extension.
      module Discoverable
        def test_responds_to_get_handler
          assert_respond_to @object, :get_handler
        end
      end
    end
  end
end