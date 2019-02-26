['Carrots', 'Milk', 'Cheese', 'Pop Tarts', 'Root Beer'].each do |item_name|
  Item.create(name: item_name)
end

['Beef Stew'].each do |meal_name|
  Assembly.create(name: meal_name)
end
