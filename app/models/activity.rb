class Activity < ActiveRecord::Base

  attr_accessible \
      :company_id,
      :default,
      :description,
      :display_order,
      :key

  def self.default
    where(default: true).limit(1).first
  end

end
