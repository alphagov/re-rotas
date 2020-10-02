require "English"
require "test_helper"

class VersionControllerTest < ActionDispatch::IntegrationTest
  test "should show the git sha" do
    get version_url

    assert_match "dev", response.body
  end
end
