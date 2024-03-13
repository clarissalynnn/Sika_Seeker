class Order < ApplicationRecord
  belongs_to :customer, class_name: "User", foreign_key: "customer_id"
  belongs_to :driver, -> { where(is_driver: true) }, class_name: "User", foreign_key: "driver_id"
  has_many :order_items

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  has_many :items, through: :order_items

  enum status: { pending: 0, payment_successful: 1, in_progress: 2, out_for_delivery: 3, completed: 4 }

  # validates :status, inclusion: { in: %w(pending in_progress out_for_delivery completed),
  #                                 message: "%{value} is not a valid status" }

  validate :driver_must_be_driver

  private

  def driver_must_be_driver
    errors.add(:driver, "must be a driver") unless driver&.is_driver?
  end
end
