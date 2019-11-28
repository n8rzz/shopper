puts '=== Departments'

group_user = Group.first
non_group_user = User.find_by(email: 'member@example.com')
department_names = ['Produce', 'Meat', 'Bakery', 'Deli', 'Dairy', 'Fozen', 'Pasta', 'Bread']

department_names.each do |department_name|
  Department.create(
    name: department_name,
    ownable: [group_user, non_group_user].sample
  )

  print '.'
end

print "\n\n"
