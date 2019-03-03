department_names = ['Produce', 'Meat', 'Bakery', 'Deli', 'Dairy', 'Fozen', 'Pasta', 'Bread']
department_names.each do |department_name|
  Department.create(name: department_name)
end

10.times do
  Location.create(
    name: Faker::Company.name,
    city: Faker::TvShows::GameOfThrones.city,
    state: Faker::Movies::StarWars.planet
  )
end

# item_names = ['Carrots', 'Milk', 'Cheese', 'Pop Tarts', 'Root Beer', 'Sweet Potato Sun Chips']

15.times do
  Item.create(
    name: Faker::Food.ingredient,
    department_id: Department.order('random()').first.id
  )
end

3.times.each do
  a = Assembly.create(name: Faker::Food.dish)
  a.item_ids = Item.order('random()').first.id
end

order_statuses = ['pending', 'active', 'canceled', 'complete']
o = Order.create(status: order_statuses[0])
o.order_item_ids << OrderItem.create(order_id: Order.first.id, item_id: Item.order('random()').first.id)
o.order_item_ids << OrderItem.create(order_id: Order.first.id, assembly_id: Assembly.order('random()').first.id)

