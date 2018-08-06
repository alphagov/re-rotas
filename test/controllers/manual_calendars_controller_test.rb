require 'test_helper'

class ManualCalendarsControllerTest < ActionDispatch::IntegrationTest
  test "should get events" do
    get manual_calendars_events_url
    assert_response :success
  end

end
