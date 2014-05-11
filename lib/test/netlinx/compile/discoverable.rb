shared_examples "discoverable" do
  it { should respond_to :get_handler }
end