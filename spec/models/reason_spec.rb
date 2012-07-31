require 'spec_helper'

describe Reason do

  def attributes
    { background_color: "#AABBCC",
      color: "#DDEEFF",
      company_id: 1,
      description: "description" }
  end

  it_behaves_like "accessible attributes"
  it_behaves_like "default key"

end
