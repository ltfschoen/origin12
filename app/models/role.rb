class Role < ActiveRecord::Base

  attr_accessible \
    :default,
    :deleted_at,
    :key,
    :name,
    :parent_id

  scope :default, where(default: true)

end
