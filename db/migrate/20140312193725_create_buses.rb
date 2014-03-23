class CreateBuses < ActiveRecord::Migration
  def change
    create_table :buses do |t|
      t.integer :capacity, null: false
      t.integer :employee_id

      t.timestamps
    end
  end
end