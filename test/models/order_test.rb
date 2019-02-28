require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  def setup
    @valid_pending_order = orders(:valid_pending_order)
  end

  def teardown
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
end
