class CreateHoursStations < ActiveRecord::Migration
  def change
    create_table :hours_stations, :id => false do |t|
      t.integer :hour_id
      t.integer :station_id

      t.timestamps
    end
  end
end
