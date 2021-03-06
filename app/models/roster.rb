class Roster < ActiveRecord::Base

  DEFAULT_ORDER = "roster_dates.date ASC, rosters.shift ASC"
  DEFAULT_HOURS = 8

  attr_accessible \
    :customer_id,
    :project_id,
    :roster_date,
    :activity_id,
    :description,
    :hours,
    :shift

  belongs_to :company
  belongs_to :customer
  belongs_to :project
  belongs_to :roster_date
  belongs_to :activity

  has_one :employee, through: :roster_date

  delegate :date, to: :roster_date

  scope :default_order, ->(attribute = nil) {
    order attribute || DEFAULT_ORDER
  }

  validates_presence_of :project_id

  def schedule_rate
    project.schedule_rates.employee(employee).date(date).first
  end

  after_create :initialize_key

  after_initialize :initialize_new_record

private

  def initialize_key
    if key.nil?
      update_attribute(:key, self.id)
    end
  end

  def initialize_new_record
    if new_record?
      self.activity ||= Activity.default
      self.hours ||= DEFAULT_HOURS
    end
  end

end
