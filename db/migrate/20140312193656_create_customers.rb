class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :identity, null: false, limit: 20
      t.string :name, null: false, limit: 50
      t.string :surname, null: false, limit: 50
      t.string :gender, null: false, limit: 1

      t.timestamps
    end
  end
end
