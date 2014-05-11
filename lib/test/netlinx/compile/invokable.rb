shared_examples "invokable" do
  it { should respond_to :compile }
end
