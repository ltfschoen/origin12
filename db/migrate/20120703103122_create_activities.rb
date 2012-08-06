class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities, force: true do |t|
      t.string    :key
      t.integer   :company_id
      t.string    :description
      t.integer   :display_order
      t.string    :color
      t.string    :background_color
      t.boolean   :default
      t.timestamps
      t.date      :deleted_at
    end
  end
end
