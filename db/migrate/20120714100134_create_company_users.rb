class CreateCompanyUsers < ActiveRecord::Migration
  def change
    create_table :company_users, force: true do |t|
      t.integer :company_id
      t.integer :user_id
      t.timestamps
    end
    add_index :company_users, [ :company_id, :user_id ] rescue nil
    add_index :company_users, :user_id rescue nil
  end
end
