shared_examples "default key" do
  it "has a default key" do
    object = described_class.create! attributes
    object.reload.key.should == object.id.to_s
  end
end
