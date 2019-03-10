require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  setup do
    @valid_pending_order = orders(:valid_pending_order)
  end

  teardown do
    @valid_pending_order = nil
  end

  test 'valid Order' do
    assert @valid_pending_order.valid?
  end

  test 'validates status presence' do
    invalid_order = Order.create(status: '')

    refute invalid_order.valid?
  end

  test 'validates status value' do
    invalid_order = Order.create(status: 'threeve')

    refute invalid_order.valid?
  end

  # test 'items_not_in_assemblies' do
  #   item = items(:valid_item)
  #   assembly = assemblies(:valid_assembly)
  #   order = orders(:valid_active_order)

  #   order.order_items.new(item_id: item.id)
  #   assembly.items.each do |assembly_item|
  #     order.order_items.new(item_id: item.id, assembly_id: assembly_item)
  #   end

  #   order.save
  # end

  # test 'items_in_assemblies' do
  #   order = orders(:valid_active_order)

  # end
end
