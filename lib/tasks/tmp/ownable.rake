# lib/tasks/tmp/ownable.rake
namespace :ownable do
  desc "Update Locations to include ownable"
  task locations: :environment do
    group_owner = Group.first
    locations = Location.where(ownable_type: nil)

    puts "Preparing to update #{locations.count} locations"

    ActiveRecord::Base.transaction do
      locations.each do |location|
        location.ownable_type = 'Group'
        location.ownable_id = group_owner.id

        location.save!

        print "."
      end
    end

    puts
    puts " --- Locations update complete"
    puts
    puts
  end

  desc "Update Departments to include ownable"
  task departments: :environment do
    group_owner = Group.first
    departments = Department.where(ownable_type: nil)

    puts "Preparing to update #{departments.count} departments"

    ActiveRecord::Base.transaction do
      departments.each do |department|
        department.ownable_type = 'Group'
        department.ownable_id = group_owner.id

        department.save!

        print "."
      end
    end

    puts
    puts " --- Departments update complete"
    puts
    puts
  end

  desc "Update Items to include ownable"
  task items: :environment do
    group_owner = Group.first
    items = Item.where(ownable_type: nil)

    puts "Preparing to update #{items.count} items"

    ActiveRecord::Base.transaction do
      items.each do |item|
        item.ownable_type = 'Group'
        item.ownable_id = group_owner.id

        item.save!

        print "."
      end
    end

    puts
    puts " --- Items update complete"
    puts
    puts
  end

  desc "Update Assemblies to include ownable"
  task assemblies: :environment do
    group_owner = Group.first
    assemblies = Assembly.where(ownable_type: nil)

    puts "Preparing to update #{assemblies.count} assemblies"

    ActiveRecord::Base.transaction do
      assemblies.each do |assembly|
        assembly.ownable_type = 'Group'
        assembly.ownable_id = group_owner.id

        assembly.save!

        print "."
      end
    end

    puts
    puts " --- Assemblies update complete"
    puts
    puts
  end

  desc "Update Orders to include ownable"
  task orders: :environment do
    group_owner = Group.first
    orders = Order.where(ownable_type: nil)

    puts "Preparing to update #{orders.count} orders"

    ActiveRecord::Base.transaction do
      orders.each do |order|
        order.ownable_type = 'Group'
        order.ownable_id = group_owner.id

        order.save!

        print "."
      end
    end

    puts
    puts " --- Orders update complete"
    puts
    puts
  end

  desc "Update Orders to include ownable"
  task meal_schedules: :environment do
    group_owner = Group.first
    meal_schedules = MealSchedule.where(ownable_type: nil)

    puts "Preparing to update #{meal_schedules.count} meal_schedules"

    ActiveRecord::Base.transaction do
      meal_schedules.each do |meal_schedule|
        meal_schedule.ownable_type = 'Group'
        meal_schedule.ownable_id = group_owner.id

        meal_schedule.save!

        print "."
      end
    end

    puts
    puts " --- MealSchedules update complete"
    puts
    puts
  end
end
