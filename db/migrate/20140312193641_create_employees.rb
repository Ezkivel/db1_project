class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.string :identity, null: false, limit: 20
      t.string :name, null: false, limit: 50
      t.string :surname, null: false, limit: 50
      t.integer :age
      t.string :gender, limit: 1
      t.string :employee_type, null: false, limit: 30
      t.string :email, null: false
      t.integer :station_id

      t.timestamps
    end
  end
end
