module NetLinx
  # An object that can be compiled with NetLinxCompiler.
  module Compilable
    
    def test_responds_to_compiler_target_files
      assert_respond_to @object, :compiler_target_files
    end
    
    def test_responds_to_compiler_include_paths
      assert_respond_to @object, :compiler_include_paths
    end
    
    def test_responds_to_compiler_library_paths
      assert_respond_to @object, :compiler_library_paths
    end
    
    def test_responds_to_compiler_module_paths
      assert_respond_to @object, :compiler_module_paths
    end
    
    
    def test_compiler_target_files_is_an_array
      assert @object.compiler_target_files.is_a? Array
    end
      
    def test_compiler_include_paths_is_an_array
      assert @object.compiler_include_paths.is_a? Array
    end
      
    def test_compiler_library_paths_is_an_array
      assert @object.compiler_library_paths.is_a? Array
    end
      
    def test_compiler_module_paths_is_an_array
      assert @object.compiler_module_paths.is_a? Array
    end
    
  end
end