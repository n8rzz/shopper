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

20.times do
  Item.create(
    name: Faker::Food.ingredient,
    department_id: Department.order('random()').first.id
  )
end

5.times.each do
  a = Assembly.create(name: Faker::Food.dish)

  rand(1..5).times do
    a.item_ids = Item.order('random()').first.id
  end
end

order_statuses = ['pending', 'active', 'canceled', 'complete']
order_statuses.each do |order_status|
  o = Order.create(status: order_status, location: Location.order('random()').first.id)
  o.order_item_ids << OrderItem.create(
    order_id: Order.last.id,
    item_id: Item.order('random()').first.id,
    status: ['open', 'closed'].sample
  )
  o.order_item_ids << OrderItem.create(
    order_id: Order.last.id,
    assembly_id: Assembly.order('random()').first.id,
    status: ['open', 'closed'].sample
  )
  o.save
end

