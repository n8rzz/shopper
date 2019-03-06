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
    department_id: Department.all.sample.id
  )
end

5.times.each do
  a = Assembly.create(name: Faker::Food.dish)

  rand(1..5).times do
    a.item_ids = Item.all.sample.id
  end
end

order_statuses = ['pending', 'active', 'canceled', 'complete']
order_statuses.each do |order_status|
  o = Order.create(status: order_status, location_id: Location.all.sample.id)
  o.order_item_ids << OrderItem.create(
    order_id: Order.last.id,
    item_id: Item.all.sample.id,
    status: ['open', 'closed'].sample
  )
  o.order_item_ids << OrderItem.create(
    order_id: Order.last.id,
    assembly_id: Assembly.all.sample.id,
    status: ['open', 'closed'].sample
  )
  o.save
end

