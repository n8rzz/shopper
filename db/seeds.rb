department_names = ['Produce', 'Meat', 'Bakery', 'Deli', 'Dairy', 'Fozen', 'Pasta', 'Bread']
department_names.each do |department_name|
  Department.create(name: department_name)
end

5.times do
  Location.create(
    name: Faker::Company.name,
    city: Faker::TvShows::GameOfThrones.city,
    state: Faker::Movies::StarWars.planet
  )
end

40.times do
  Item.create(
    name: Faker::Food.ingredient,
    department_id: Department.all.sample.id
  )
end

7.times.each do
  a = Assembly.create(name: Faker::Food.dish)

  rand(1..10).times do
    a.assembly_items.new(
      qty: rand(1..42),
      item_id: Item.all.sample.id
    )
  end

  a.save
end

order_statuses = ['active', 'cancelled', 'complete']
10.times.each do |order_status|
  o = Order.create(
    status: order_statuses.sample,
    location_id: Location.all.sample.id,
    shopping_date: Faker::Date.between(from: 1.year.ago, to: 1.year.from_now)
  )

  rand(1..3).times do
    item = Item.all.sample

    o.order_items.new(
      order_id: Order.last.id,
      item_id: item.id,
      department_id: item.department.id,
      picked: [true, false].sample,
      qty: rand(1..5)
    )
  end

  o.save
end

