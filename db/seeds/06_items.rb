puts '=== Items'

rand(13..42).times do
  Item.create(
    name: Faker::Food.ingredient,
    department_id: Department.all.sample.id
  )

  print ','
end

print "\n\n"
