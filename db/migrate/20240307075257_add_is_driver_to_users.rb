class AddIsDriverToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :is_driver, :boolean
  end
end
