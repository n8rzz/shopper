item_names = ['Carrots', 'Milk', 'Cheese', 'Pop Tarts', 'Root Beer']

item_names.each do |item_name|
  Item.create(name: item_name)
end

['Beef Stew'].each do |meal_name|
  a = Assembly.create(name: meal_name)
  a.item_ids = Item.first.id
end

order_statuses = ['pending', 'active', 'complete']
o = Order.create(status: order_statuses[0])
o.order_item_ids << OrderItem.create(order_id: Order.first.id, item_id: Item.first.id)
o.order_item_ids << OrderItem.create(order_id: Order.first.id, assembly_id: Assembly.first.id)

department_names = ['Produce', 'Meat', 'Bakery', 'Deli', 'Dairy', 'Fozen', 'Pasta', 'Bread']

department_names.each do |department_name|
  Department.create(name: department_name)
end
