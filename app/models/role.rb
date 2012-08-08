class Role < ActiveRecord::Base

  attr_accessible \
    :default,
    :deleted_at,
    :key,
    :name,
    :parent_id

  acts_as_tree order: 'name'

  def self.default
    where(default: true).order('created_at DESC').limit(1).first
  end

  def self_and_ancestors
    [ self ] + ancestors
  end

end
