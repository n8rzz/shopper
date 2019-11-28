print "\n\n"
puts '--- === ::: Generating Database Seeds ::: === ---'
print "\n\n"
puts '=== Groups'

# 2.times do
Group.create(
  name: Faker::Company.industry,
  description: Faker::Company.bs,
)

print '.'
# end

print "\n\n"
