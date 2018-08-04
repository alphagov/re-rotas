require 'test_helper'

class CalendarsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get calendars_index_url
    assert_response :success
  end

  test "should get forward" do
    get calendars_forward_url
    assert_response :success
  end

end
