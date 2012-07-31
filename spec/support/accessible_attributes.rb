shared_examples "accessible attributes" do
  it "do not raise MassAssignmentSecurity error" do
    expect { described_class.create! attributes }.to_not raise_error(ActiveModel::MassAssignmentSecurity::Error)
  end
end
