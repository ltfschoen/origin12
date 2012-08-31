class Company < ActiveRecord::Base

  attr_accessible \
      :key,
      :name

  acts_as_tree order: 'name'

  has_many :customers
  has_many :projects
  has_many :teams
  has_many :roster_dates

  has_many :company_employees
  has_many :employees, through: :company_employees

  has_many :users, through: :employees

  scope :default_order, order('name ASC')

  alias_attribute :display_name, :name

  before_create :assign_root_as_employee

  def self.default_employee
    Employee.root
  end

  def self_and_children
    self.class.where([ 'id = ? OR parent_id = ?', self[:id], self[:id] ])
  end

  def managers
    # TODO Define managers
    employees
  end

private

  def assign_root_as_employee
    unless employees.include?(Employee.root)
      employees.push(Employee.root)
    end
  end

end
