class Activity < ActiveRecord::Base

  attr_accessible \
    :background_color,
    :company_id,
    :color,
    :default,
    :description,
    :display_order,
    :key

  def self.default
    where(default: true).limit(1).first
  end

  after_create :initialize_key

private

  def initialize_key
    if key.nil?
      update_attribute(:key, self.id)
    end
  end

end
