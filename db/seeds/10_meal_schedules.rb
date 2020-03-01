puts '=== MealSchedules'

group_user = User.find_by(email: 'me@example.com').groups.first
meal_time_option_list = %w[morning afternoon evening none]
date_for_all_meal_times = Faker::Date.between(from: 1.week.ago, to: 1.month.from_now)

meal_time_option_list.each do |meal_time|
  MealSchedule.create(
    schedule_date: date_for_all_meal_times,
    purchased: false,
    item_id: group_user.items.all.sample.id,
    meal_time: meal_time,
    ownable: group_user
  )

  print '.'
end

2.times.each do
  MealSchedule.create(
    schedule_date: date_for_all_meal_times,
    purchased: false,
    item_id: group_user.items.all.sample.id,
    meal_time: 'morning',
    ownable: group_user
  )

  print '.'
end

2.times.each do
  MealSchedule.create(
    schedule_date: date_for_all_meal_times,
    purchased: false,
    item_id: group_user.items.all.sample.id,
    meal_time: 'afternoon',
    ownable: group_user
  )

  print '.'
end

rand(32..42).times.each do
  MealSchedule.create(
    schedule_date: Faker::Date.between(from: 2.months.ago, to: 2.months.from_now),
    purchased: [true, false].sample,
    item_id: group_user.items.all.sample.id,
    meal_time: meal_time_option_list.sample,
    ownable: group_user
  )

  print '.'
end

rand(17..32).times.each do
  MealSchedule.create(
    schedule_date: Faker::Date.between(from: 1.month.ago, to: 2.months.from_now),
    purchased: [true, false].sample,
    assembly_id: group_user.assemblies.all.sample.id,
    meal_time: meal_time_option_list.sample,
    ownable: group_user
  )

  print '.'
end

print "\n\n"
