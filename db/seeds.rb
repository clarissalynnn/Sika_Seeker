require 'faker'
require_relative 'items.rb'


# Destroy existing data
puts "Destroying existing data..."

OrderItem.destroy_all
Order.destroy_all
Item.destroy_all
User.destroy_all

puts "Seeding users..."

# Create Users
10.times do
  User.create!(
    email: Faker::Internet.unique.email,
    password: 'password' # You may want to change this for better security
  )
end

puts "#{User.count} users seeded."

puts "Seeding items..."

# Create Items
[Items::RICE, Items::ANIMAL_PROTEIN, Items::PLANT_PROTEIN, Items::VEGETABLES].each do |category|
  category.each do |item_data|
    Item.create!(
      name: item_data[:name],
      description: item_data[:description],
      photo: item_data[:photo_url], # assuming photo_url is a direct link to an image
      price: item_data[:price]
    )
  end
  
puts "#{Item.count} items seeded."

puts "Seeding orders..."

# Create Orders
users = User.all
items = Item.all

# Create a single driver
driver = User.create!(
  email: Faker::Internet.unique.email,
  password: 'password' # You may want to change this for better security
)
puts "Driver created: #{driver.email}"

20.times do
  order = Order.create!(
    order_date: Faker::Date.backward(days: 14),
    address: Faker::Address.full_address,
    total_price: Faker::Commerce.price(range: 10..200.0, as_string: true),
    latitude: Faker::Address.latitude,
    longitude: Faker::Address.longitude,
    customer_id: users.sample.id,
    driver_id: driver.id # Assign the driver to each order
  )

  # Create Order Items
  rand(1..5).times do
    OrderItem.create!(
      order: order,
      item: items.sample,
      quantity: rand(1..5)
    )
  end
end

puts "#{Order.count} orders seeded."
puts "#{OrderItem.count} order items seeded."
