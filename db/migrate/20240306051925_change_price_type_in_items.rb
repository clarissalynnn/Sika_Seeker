class ChangePriceTypeInItems < ActiveRecord::Migration[7.1]
  def change
    change_column :items, :price, :integer
  end
end
