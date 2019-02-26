item_names = ['Carrots', 'Milk', 'Cheese', 'Pop Tarts', 'Root Beer']

item_names.each do |item_name|
  Item.create(name: item_name)
end

['Beef Stew'].each do |meal_name|
  a = Assembly.create(name: meal_name)
  a.item_ids = [1, 2]
end
