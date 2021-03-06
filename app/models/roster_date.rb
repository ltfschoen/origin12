class RosterDate < ActiveRecord::Base

  MAXIMUM_SHIFTS = 3
  HOURS_PER_DAY  = 8.0
  ETERNITY_DATE  = Date.parse('9999-12-31')
  DEFAULT_ORDER  = "date ASC"

  attr_accessible \
    :date,
    :company_id,
    :employee_id,
    :locked,
    :rosters_attributes

  validates_uniqueness_of :date,
    scope: [ :company_id, :employee_id ]

  belongs_to :employee

  belongs_to :company

  has_many :rosters, :dependent => :destroy

  scope :week, ->(date) {
    where(date: date.beginning_of_week(:sunday)..(date.end_of_week(:saturday) + 1.day))
  }

  scope :wdays, lambda { |wdays|
    # mysql: where([ '((weekday(`date`) + 1) % 7) in (?)', wdays])
    where([ 'EXTRACT(DOW FROM date)::NUMERIC IN (?)', wdays])
  }

  scope :date, ->(date) {
    where date: date
  }

  scope :default_order, order(DEFAULT_ORDER)

  scope :employee, lambda { |employee| where(employee_id: employee[:id]) }

  scope :company, lambda { |company| where(company_id: company[:id]) }

  scope :unlocked, where(locked: false)

  accepts_nested_attributes_for :rosters,
      allow_destroy: true,
      reject_if: proc { |attrs| attrs['customer_id'].blank? || attrs['project_id'].blank? }

  alias_method :rosters_attributes_without_company=, :rosters_attributes=

  def rosters_attributes=(attrs)
    self.rosters_attributes_without_company = attrs
    rosters.each do |roster|
      if roster.new_record?
        roster.company = company
      end
    end
  end

  def build_default_rosters
    rosters_length = rosters.length
    remaining_shifts = MAXIMUM_SHIFTS - rosters_length
    remaining_shifts.times do |shift|
      shift_index = rosters_length + shift - 1
      rosters.build shift: shift_index
    end
  end

  def self.duplicate(employee, company, opts)
    transaction do
      date  = Date.parse(opts[:date])
      weeks = opts[:weeks] ? opts[:weeks].to_i : 0
      self.week(date).wdays(opts[:wday]).employee(employee).company(company).each do |roster_date|
        roster_date.duplicate *future_dates(roster_date, weeks)
      end
    end
  end

  # Duplicate roster_date for new dates provided
  # either as strings (yyyy-mm-dd) or date objects.
  def duplicate(*dates)
    map_date_strings_to_dates! dates
    RosterDate.destroy_all date: dates, employee_id: employee_id, company_id: company_id, locked: false
    dates.each do |date|
      roster_date = self.dup
      roster_date.date = date
      roster_date.rosters << rosters.map(&:dup)
      roster_date.save
    end
  end

private

  def map_date_strings_to_dates!(dates)
    dates.map! do |date|
      date.is_a?(String) ? Date.parse(date) : date
    end
  end

  def self.future_dates(roster_date, weeks)
    ([ roster_date ] * weeks.abs).each_with_index.map do |roster_date, week_ordinal|
      roster_date.date + (week_ordinal + 1).weeks
    end
  end

end
