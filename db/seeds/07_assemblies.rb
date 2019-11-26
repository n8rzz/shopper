puts '=== Assemblies'

7.times.each do
  a = Assembly.create(name: Faker::Food.dish)

  rand(1..10).times do
    a.assembly_items.new(
      qty: rand(1..42),
      item_id: Item.all.sample.id
    )
  end

  a.save

  print '.'
end

print "\n\n"
