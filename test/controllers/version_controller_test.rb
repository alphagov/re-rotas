require 'English'
require 'test_helper'

class VersionControllerTest < ActionDispatch::IntegrationTest
  test "should show the git sha" do
    git_sha = `git rev-parse HEAD`.strip
    assert $CHILD_STATUS.success?

    get version_url

    assert_match git_sha, response.body
  end

end
