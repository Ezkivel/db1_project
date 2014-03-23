class CreatePackages < ActiveRecord::Migration
  def change
    create_table :packages do |t|
      t.string :package_type, limit: 30
      t.string :addressee, null: false, limit: 50
      t.decimal :total, null: false
      t.integer :customer_id
      t.integer :employee_id
      t.integer :hour_id

      t.timestamps
    end
  end
end