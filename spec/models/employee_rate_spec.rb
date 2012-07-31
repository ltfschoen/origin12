require 'spec_helper'

describe EmployeeRate do

  def attributes
    date = Date.parse '201203021'
    { employee_id: 666,
      team_id: 1,
      card_rate: 10.00,
      cost_rate: 20.00,
      internal_rate: 30.00,
      until: date }
  end

  it_behaves_like "accessible attributes"

end
