class CreateHours < ActiveRecord::Migration
  def change
    create_table :hours do |t|
      t.datetime :hour, null: false
      t.string :destination, null: false, limit: 50
      t.integer :bus_id

      t.timestamps
    end
  end
end