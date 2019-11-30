puts '=== Assemblies'

group_user = User.find_by(email: 'me@example.com').groups.first

7.times.each do
  a = Assembly.create(
    name: Faker::Food.dish,
    ownable: group_user
  )

  rand(1..10).times do
    a.assembly_items.new(
      qty: rand(1..42),
      item_id: group_user.items.all.sample.id
    )
  end

  a.save

  print '.'
end

print "\n\n"
