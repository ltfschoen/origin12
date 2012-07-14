class CreateRosterDates < ActiveRecord::Migration
  def change
    create_table :roster_dates, force: true do |t|
      t.integer   :company_id
      t.integer		:employee_id
      t.date 			:date
      t.boolean		:locked
      t.timestamps
    end
    add_index :roster_dates, [ :employee_id, :date ], unquie: true
  end
end
