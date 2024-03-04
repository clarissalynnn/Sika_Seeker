class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.date :order_date
      t.string :address
      t.decimal :total_price
      t.float :latitude
      t.float :longitude
      t.timestamps
    end
  end
end
