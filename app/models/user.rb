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

  attr_accessible :email

  ###

  has_one :employee, autosave: true

  accepts_nested_attributes_for :employee

  delegate :first_name, :last_name, to: :employee

  ###

  has_many :company_users

  accepts_nested_attributes_for :company_users

  has_many :companies, through: :company_users

  def default_company
    companies.first
  end

  ###

  after_initialize :initialize_employee

private

  def initialize_employee
    if new_record?
      build_employee unless employee.present?
      company_users.build if company_users.empty?
    end
  end

end
