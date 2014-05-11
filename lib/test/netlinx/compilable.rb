shared_examples "compilable" do
  
  it { should respond_to :compiler_target_files  }
  it { should respond_to :compiler_include_paths }
  it { should respond_to :compiler_library_paths }
  it { should respond_to :compiler_module_paths  }
  
  its(:compiler_target_files)  { should be_an Array }
  its(:compiler_include_paths) { should be_an Array }
  its(:compiler_library_paths) { should be_an Array }
  its(:compiler_module_paths)  { should be_an Array }
  
end
