class Company < ActiveRecord::Base

  attr_accessible \
      :key,
      :name

  acts_as_tree order: 'name'

  has_many :customers
  has_many :projects
  has_many :teams
  has_many :roster_dates

  has_many :company_users
  has_many :users, through: :company_users
  has_many :employees, through: :users

  alias_attribute :display_name, :name

  def self_and_children
    self.class.where([ 'id = ? OR parent_id = ?', self[:id], self[:id] ])
  end

  def managers
    # TODO Define managers
    employees
  end

end
