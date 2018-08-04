require 'test_helper'

class ManualCalendarsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get manual_calendars_index_url
    assert_response :success
  end

  test "should get show" do
    get manual_calendars_show_url
    assert_response :success
  end

  test "should get new" do
    get manual_calendars_new_url
    assert_response :success
  end

  test "should get create" do
    get manual_calendars_create_url
    assert_response :success
  end

end
