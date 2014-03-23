class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.datetime :reservation_date
      t.integer :seat, null: false
      t.string :ticket_type, limit: 50
      t.decimal :discount
      t.decimal :total, null: false
      t.integer :customer_id
      t.integer :employee_id
      t.integer :hour_id

      t.timestamps
    end
  end
end