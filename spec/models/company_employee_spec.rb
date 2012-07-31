require 'spec_helper'

describe CompanyEmployee do

  def attributes
    { company_id: 666, employee_id: 777 }
  end

  it_behaves_like "accessible attributes"

end
