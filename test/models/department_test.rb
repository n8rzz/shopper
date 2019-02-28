require 'test_helper'

class DepartmentTest < ActiveSupport::TestCase
  def setup
    @valid_department = departments(:valid_department)
  end

  def teardown
    @valid_department = nil
  end

  test 'valid Department' do
    assert @valid_department.valid?
  end

  test 'department uniqueness' do
    duplicate_department = Department.create(name: 'Produce')

    refute duplicate_department.valid? 'Saved duplicate Department name'
  end
end
