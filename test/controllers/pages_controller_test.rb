require 'test_helper'
require 'helpers/auth_helper'
require 'helpers/teams_helper'

class PagesControllerTest < ActionDispatch::IntegrationTest
  test 'should not allow access to main page when not logged in' do
    get root_path
    assert_redirected_to controller: :sessions, action: :new
  end

  test 'should show information about a team even if no one is on a rota, when signed in' do
    create_test_session_with_fake_auth
    create_team("Biscuits", "Ensures quality biscuit supply")
    get root_path
    assert_response :success
    assert_select "h1", "Currently on rotas"
    assert_select("a:match('href', ?)", %r{/teams/biscuits}) do |result|
        assert_match /Biscuits/, result.text, "No biscuits found, check your cookies!"
    end
    assert_select "p.govuk-body", "There is currently no one on a rota for Biscuits"
  end
end
