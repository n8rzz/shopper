item_names = ['Carrots', 'Milk', 'Cheese', 'Pop Tarts', 'Root Beer']

item_names.each do |item_name|
  Item.create(name: item_name)
end

['Beef Stew'].each do |meal_name|
  a = Assembly.create(name: meal_name)
  a.item_ids = Item.first.id
end

order_statuses = ['Pending', 'Active', 'Complete']
order_statuses.each do |status|
  o = Order.create(status: status)

  unless rand(0..1) == 1
    OrderItem.create(order_id: o.id, assembly_id: Item.first.id)
  end

  OrderItem.create(order_id: o.id, item_id: Item.first.id)
end
