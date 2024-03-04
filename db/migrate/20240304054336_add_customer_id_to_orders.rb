class AddCustomerIdToOrders < ActiveRecord::Migration[7.1]
  def change
    add_reference :orders, :customer, foreign_key: { to_table: :users }
  end
end
