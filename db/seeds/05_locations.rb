puts '=== Locations'

2.times do
  Location.create(
    name: Faker::Company.name,
    city: Faker::TvShows::GameOfThrones.city,
    state: Faker::Movies::StarWars.planet
  )

  print '.'
end

print "\n\n"
puts '=== Seeding LocationDepartments'

Department.all.each_with_index do |department, index|
  if index > 5
    break
  end

  LocationDepartment.create(
    department_id: department.id,
    location_id: Location.first.id,
    sort_order: index,
  )

  print '.'
end

print "\n\n"
