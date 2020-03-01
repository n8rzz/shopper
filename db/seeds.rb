# TODO: there is probably a better way to do this as a one-liner
require_relative './seeds/01_groups.rb'
require_relative './seeds/02_users.rb'
require_relative './seeds/03_user_groups.rb'
require_relative './seeds/04_departments.rb'
require_relative './seeds/05_locations.rb'
require_relative './seeds/06_items.rb'
require_relative './seeds/07_assemblies.rb'
require_relative './seeds/08_recipes.rb'
require_relative './seeds/09_orders.rb'
require_relative './seeds/10_meal_schedules.rb'

puts 'Seeding complete!'
