class Activity < ActiveRecord::Base

  NONWORKING_DAY_KEY = 'nonworking_day'
  UNPLANNED_BENCH = 'unplanned_bench'

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

  class << self
    def nonworking_day
      @nonworking_date ||= find_by_key NONWORKING_DAY_KEY
    end

    def unplanned_bench
      @unplanned_bench ||= find_by_key UNPLANNED_BENCH
    end
  end

private

  def initialize_key
    if key.nil?
      update_attribute(:key, self.id)
    end
  end

end
