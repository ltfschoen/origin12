class Employee < ActiveRecord::Base

  DEFAULT_ORDER = "employees.last_name"

  attr_accessible \
      :email,
      :employee_rates_attributes,
      :first_name,
      :key,
      :last_name,
      :role_id,
      :schedule_rates_attributes,
      :started_at,
      :terminated_at

  belongs_to :user
  belongs_to :role

  has_many :employee_rates
  has_many :schedule_rates
  has_many :roster_dates

  has_many :company_employees
  has_many :companies, through: :company_employees

  validates_presence_of :first_name, :last_name
  validates_presence_of :email, on: :create

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

  alias :display_name :full_name

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
    if role.nil?
      self.role = Role.default
    end
  end

end
