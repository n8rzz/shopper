puts '=== UserGroups'

admin = User.find_by!(email: 'me@example.com')
member = User.find_by!(email: 'member@example.com')

[admin].each do |u|
  UserGroup.create(
    user_id: u.id,
    group_id: Group.first.id
  )

  print '.'
end

print "\n\n"
