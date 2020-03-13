# frozen_string_literal: true

puts '=== Recipes'

group_user = User.find_by(email: 'me@example.com').groups.first

rand(1..5).times.each do
  Recipe.create(
    name: Faker::Food.dish,
    description: Faker::Food.description,
    prep_time: rand(1..42),
    cook_time: rand(1..42),
    yield_value: rand(1..42),
    yield_unit: %w[servings pounds gallons].sample,
    ownable: group_user
  )

  rand(1..5).times.each do |i|
    RecipeIngredient.create(
      recipe_id: Recipe.last.id,
      name: Faker::Food.ingredient,
      qty_unit: Faker::Measurement.metric_volume,
      qty_value: rand(1..42),
    )
  end

  rand(1..5).times.each do |i|
    RecipeInstruction.create(
      recipe_id: Recipe.last.id,
      sort_order: i,
      text: Faker::Hipster.paragraph
    )
  end

  print '.'
end

Recipe.create(
  description: Faker::Food.description,
  prep_time: rand(1..42),
  cook_time: rand(1..42),
  yield_value: rand(1..42),
  yield_unit: %w[servings pounds gallons].sample,
  ownable: group_user,
  assembly_id: group_user.assemblies.first.id
)

rand(1..3).times.each do |i|
  RecipeIngredient.create(
    recipe_id: Recipe.last.id,
    name: Faker::Food.ingredient,
    qty_unit: %w[monkeys lions tigers liters quarts Tbs tbsp cups].sample,
    qty_value: rand(1..42),
  )
end

rand(1..3).times.each do |i|
  RecipeIngredient.create(
    recipe_id: Recipe.last.id,
    name: '',
    qty_unit: %w[monkeys lions tigers liters quarts Tbs tbsp cups].sample,
    qty_value: rand(1..42),
    item_id: group_user.items.sample.id
  )
end

rand(1..5).times.each do |i|
  RecipeInstruction.create(
    recipe_id: Recipe.last.id,
    sort_order: i,
    text: Faker::Hipster.paragraph
  )
end

print '.'

print "\n\n"
