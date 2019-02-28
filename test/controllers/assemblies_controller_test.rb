require 'test_helper'

class AssembliesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @valid_assembly = assemblies(:valid_assembly)
  end

  test "should get index" do
    get assemblies_url
    assert_response :success
  end

  test "should get new" do
    get new_assembly_url
    assert_response :success
  end

  test "should create assembly" do
    assert_difference('Assembly.count') do
      post assemblies_url, params: { assembly: { name: 'Hamburger Helper' } }
    end

    assert_redirected_to assembly_url(Assembly.last)
  end

  test "should show assembly" do
    get assembly_url(@valid_assembly)
    assert_response :success
  end

  test "should get edit" do
    get edit_assembly_url(@valid_assembly)
    assert_response :success
  end

  test "should update assembly" do
    patch assembly_url(@valid_assembly), params: { assembly: { name: @valid_assembly.name } }
    assert_redirected_to assembly_url(@valid_assembly)
  end

  test "should destroy assembly" do
    assert_difference('Assembly.count', -1) do
      delete assembly_url(@valid_assembly)
    end

    assert_redirected_to assemblies_url
  end
end
