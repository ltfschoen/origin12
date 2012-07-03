class Project < ActiveRecord::Base

  attr_accessible \
      :description,
      :manager_id,
      :name,
      :short_name

  alias_attribute :display_name, :name

  belongs_to :customer
  belongs_to :manager, class_name: 'Employee'
  has_many   :rosters

  after_create :initialize_key

  def as_json(opts = {})
    super only: [ :id, :key, :name ]
  end

  private

  def initialize_key
    update_attribute(:key, self.id)
  end

end
