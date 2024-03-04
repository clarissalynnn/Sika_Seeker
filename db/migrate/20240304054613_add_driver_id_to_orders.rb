class AddDriverIdToOrders < ActiveRecord::Migration[7.1]
  def change
    add_reference :orders, :driver, foreign_key: { to_table: :users }
  end
end
