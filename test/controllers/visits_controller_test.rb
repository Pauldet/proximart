require 'test_helper'

class VisitsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get visits_index_url
    assert_response :success
  end

  test "should get show" do
    get visits_show_url
    assert_response :success
  end

  test "should get create" do
    get visits_create_url
    assert_response :success
  end

  test "should get new" do
    get visits_new_url
    assert_response :success
  end

end
