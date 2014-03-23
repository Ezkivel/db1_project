class CreateStations < ActiveRecord::Migration
  def change
    create_table :stations do |t|
      t.string :name, null: false, limit: 50
      t.string :address, null: false, limit: 150
      t.string :phone, null: false, limit: 20

      t.timestamps
    end
  end
end