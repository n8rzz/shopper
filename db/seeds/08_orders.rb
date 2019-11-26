puts '=== Orders'

# intentionally leaving `pending` out of the seeds
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

  print '.'
end

15.times.each do
  o = Order.create(
    status: 'complete',
    location_id: Location.all.sample.id,
    shopping_date: Faker::Date.between(from: 1.year.ago, to: 1.year.from_now)
  )

  rand(1..5).times do
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

  print '.'
end

print "\n\n"
