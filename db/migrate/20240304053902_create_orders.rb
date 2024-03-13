class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.date :order_date
      t.string :address
      t.integer :total_price
      t.float :latitude
      t.float :longitude
      t.integer :status, default: 0
      t.timestamps
    end
  end
end
