class Role < ActiveRecord::Base

  attr_accessible \
    :default,
    :deleted_at,
    :key,
    :name,
    :parent_id

  def self.default
    where(default: true).order('created_at DESC').limit(1).first
  end

end
