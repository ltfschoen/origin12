class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string    :key
      t.string    :name
      t.integer   :parent_id
      t.boolean   :default
      t.timestamps
      t.datetime  :deleted_at
    end
  end
end
