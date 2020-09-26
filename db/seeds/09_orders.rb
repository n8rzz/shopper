puts '=== Orders'

group_user = User.find_by(email: 'me@example.com').groups.first

# intentionally leaving `pending` out of the seeds
order_statuses = ['active', 'cancelled', 'complete']

5.times.each do
  o = Order.create(
    status: order_statuses.sample,
    location_id: group_user.locations.sample.id,
    shopping_date: Faker::Date.between(from: 1.year.ago, to: 1.year.from_now),
    ownable: group_user
  )

  rand(1..15).times do
    item = group_user.items.sample

    o.order_items.new(
      order_id: group_user.orders.last.id,
      item_id: item.id,
      department_id: item.department.id,
      picked: [true, false].sample,
      qty: rand(1..5)
    )
  end

  o.save

  print '.'
end

15.times.each do
  o = Order.create(
    status: 'complete',
    location_id: group_user.locations.sample.id,
    shopping_date: Faker::Date.between(from: 1.year.ago, to: 1.year.from_now),
    ownable: group_user
  )

  rand(1..5).times do
    item = group_user.items.sample

    o.order_items.new(
      order_id: group_user.orders.last.id,
      item_id: item.id,
      department_id: item.department.id,
      picked: [true, false].sample,
      qty: rand(1..5)
    )
  end

  o.save

  print '.'
end

print "\n\n"
