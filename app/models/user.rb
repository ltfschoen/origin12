class User < ActiveRecord::Base

  attr_accessible \
      :companies,
      :email,
      :password,
      :password_confirmation,
      :company_users_attributes,
      :employee_attributes

  acts_as_authentic do |config|
    config.logged_in_timeout UserSession::INACTIVITY_TIMEOUT
  end

  has_one :employee, autosave: true

  has_many :companies, through: :employee

  before_create :attach_to_employee

  validates_presence_of :employee, on: :create, :message => 'was not found'

  def default_company
    companies.first
  end

private

  def attach_to_employee
    self.employee = Employee.find_by_email(email)
  end

end
