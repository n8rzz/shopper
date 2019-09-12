department_names = ['Produce', 'Meat', 'Bakery', 'Deli', 'Dairy', 'Fozen', 'Pasta', 'Bread']
department_names.each do |department_name|
  Department.create(name: department_name)
end

2.times do
  Location.create(
    name: Faker::Company.name,
    city: Faker::TvShows::GameOfThrones.city,
    state: Faker::Movies::StarWars.planet
  )
end

Department.all.each_with_index do |department, index|
  if index > 5
    break
  end

  LocationDepartment.create(
    department_id: department.id,
    location_id: Location.first.id,
    sort_order: index,
  )
end

rand(13..42).times do
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
5.times.each do
  o = Order.create(
    status: order_statuses.sample,
    location_id: Location.all.sample.id,
    shopping_date: Faker::Date.between(from: 1.year.ago, to: 1.year.from_now)
  )

  rand(1..15).times do
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

meal_time_option_list = ['morning', 'afternoon', 'evening', 'none']

date_for_all_meal_times = Faker::Date.between(from: 1.week.ago, to: 1.month.from_now)
meal_time_option_list.each do |meal_time|
  MealSchedule.create(
    schedule_date: date_for_all_meal_times,
    purchased: false,
    item_id: Item.all.sample.id,
    meal_time: meal_time
  )
end

2.times.each do
  MealSchedule.create(
    schedule_date: date_for_all_meal_times,
    purchased: false,
    item_id: Item.all.sample.id,
    meal_time: 'morning'
  )
end

2.times.each do
  MealSchedule.create(
    schedule_date: date_for_all_meal_times,
    purchased: false,
    item_id: Item.all.sample.id,
    meal_time: 'afternoon'
  )
end

rand(32..42).times.each do
  MealSchedule.create(
    schedule_date: Faker::Date.between(from: 2.months.ago, to: 2.months.from_now),
    purchased: [true, false].sample,
    item_id: Item.all.sample.id,
    meal_time: meal_time_option_list.sample
  )
end

rand(17..32).times.each do
  MealSchedule.create(
    schedule_date: Faker::Date.between(from: 1.month.ago, to: 2.months.from_now),
    purchased: [true, false].sample,
    assembly_id: Assembly.all.sample.id,
    meal_time: meal_time_option_list.sample
  )
end
