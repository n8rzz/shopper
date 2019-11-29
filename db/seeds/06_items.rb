puts '=== Items'

user = User.find_by(email: 'me@example.com')
group_owner = user.groups.first

rand(13..42).times do
  Item.create(
    name: Faker::Food.ingredient,
    department_id: group_owner.departments.sample.id,
    ownable: group_owner
  )

  print '.'
end


user_owner = User.find_by(email: 'member@example.com')

rand(13).times do
  Item.create(
    name: Faker::Food.ingredient,
    department_id: user_owner.departments.sample.id,
    ownable: user_owner
  )

  print '.'
end

print "\n\n"
