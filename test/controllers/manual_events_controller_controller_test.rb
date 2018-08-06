require 'test_helper'

class ManualEventsControllerControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get manual_events_controller_new_url
    assert_response :success
  end

  test "should get edit" do
    get manual_events_controller_edit_url
    assert_response :success
  end

  test "should get create" do
    get manual_events_controller_create_url
    assert_response :success
  end

  test "should get update" do
    get manual_events_controller_update_url
    assert_response :success
  end

end
