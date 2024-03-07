class Order < ApplicationRecord
  belongs_to :customer, class_name: "User", foreign_key: "customer_id"
  belongs_to :driver, -> { where(is_driver: true) }, class_name: "User", foreign_key: "driver_id"
  has_many :order_items

  validate :driver_must_be_driver

  private

  def driver_must_be_driver
    errors.add(:driver, "must be a driver") unless driver&.is_driver?
  end
end
