require 'test_helper'
require 'helpers/auth_helper'
require 'helpers/teams_helper'

class PagesControllerTest < ActionDispatch::IntegrationTest
  test 'should not allow access to main page when not logged in' do
    get root_path
    assert_redirected_to controller: :sessions, action: :new
  end
end
