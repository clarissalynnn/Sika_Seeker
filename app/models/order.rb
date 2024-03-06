class Order < ApplicationRecord
  belongs_to :customer, class_name: "User", foreign_key: "customer_id"
  belongs_to :driver, class_name: "User", foreign_key: "driver_id"
  has_many :order_items
end
