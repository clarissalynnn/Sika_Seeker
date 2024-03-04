class CreateItems < ActiveRecord::Migration[7.1]
  def change
    create_table :items do |t|
      t.string :name
      t.string :description
      t.string :photo
      t.decimal :price

      t.timestamps
    end
  end
end
