puts '=== Users'

password = 's@f3wo4d'

# This use belongs to a group
admin = User.create(
  username: 'me',
  email: 'me@example.com',
  password: password,
  password_confirmation: password,
  confirmed_at: DateTime.now
)

print '.'

# This user does not belong to a group
member = User.create(
  username: Faker::Internet.username,
  email: 'member@example.com',
  password: password,
  password_confirmation: password,
  confirmed_at: DateTime.now
)

print '.'

3.times do
  User.invite!(
    email: Faker::Internet.safe_email,
    skip_invitation: true
  )

  print '.'
end

2.times do
  User.invite!(
    email: Faker::Internet.safe_email,
    invitation_group_id: Group.first,
    skip_invitation: true
  )

  print '.'
end

print "\n\n"
