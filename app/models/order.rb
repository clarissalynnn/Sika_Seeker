class Order < ApplicationRecord
  belongs_to :customer, class_name: "User", foreign_key: "customer_id"
  belongs_to :driver, -> { where(is_driver: true) }, class_name: "User", foreign_key: "driver_id"
  has_many :order_items

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  has_many :items, through: :order_items

  validate :driver_must_be_driver
  validates :status, inclusion: { in: %w(pending in_progress out_for_delivery completed),
                                  message: "%{value} is not a valid status" }

  def calculate_total_price
    total_price = 0
    order = self
    order.order_items.each do |order_item|
      total_price += order_item.item.price * order_item.quantity
    end
    total_price
  end

  def calculate_total_quantity
    total_quantity = 0
    order = self
    order.order_items.each do |order_item|
      total_quantity += order_item.quantity
    end
    total_quantity
  end

  private

  def driver_must_be_driver
    errors.add(:driver, "must be a driver") unless driver&.is_driver?
  end

end
