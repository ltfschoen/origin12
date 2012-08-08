class Employee < ActiveRecord::Base

  DEFAULT_ORDER = "employees.key"

  attr_accessible \
    :key,
    :first_name,
    :last_name,
    :started_at,
    :terminated_at,
    :employee_rates_attributes,
    :schedule_rates_attributes

  belongs_to :user
  belongs_to :role

  has_many :employee_rates
  has_many :schedule_rates
  has_many :roster_dates

  validates_presence_of :first_name, :last_name

  scope :company, ->(company) {
    joins(:user => :company_users).
    where(company_users: { company_id: company[:id] })
  }

  scope :default_order, ->(attribute) {
    order attribute || DEFAULT_ORDER
  }

  accepts_nested_attributes_for :employee_rates,
      reject_if: :all_blank,
      allow_destroy: true

  accepts_nested_attributes_for :schedule_rates,
      reject_if: :all_blank

  before_create :assign_default_role

  def full_name
    [ self.first_name, self.last_name ].compact.join(' ')
  end

  def destroy
    touch :deleted_at
  end

  def authorized?(klass, *operations)
    true
  end

  def role?(role_key)
    if role
      role.self_and_ancestors.map(&:key).include?(role_key)
    end
  end

private

  def assign_default_role
    self.role = Role.default
  end

end
