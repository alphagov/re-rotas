require "test_helper"
require "helpers/auth_helper"

class ServicesControllerTest < ActionDispatch::IntegrationTest
  test "should create a team with name and teams" do
    name = "my service"
    expected_slug = ActiveSupport::Inflector.parameterize(name)

    team1 = Team.create(name: "my-team")
    team2 = Team.create(name: "my-other-team")

    create_test_session_with_fake_auth
    post services_path, params: { service: {
      name: name,
      team_ids: [team1.id, team2.id],
    }}
    assert_redirected_to service_path(id: expected_slug)

    service = Service.find_by_name(name)
    assert_equal service.name, name
    assert_equal service.teams, [team1, team2]
  end

  test "should update a team with name and teams" do
    name = "my service"
    expected_slug = ActiveSupport::Inflector.parameterize(name)

    service = Service.create(name: name)
    assert_equal service.name, name
    assert_equal service.teams, []

    team1 = Team.create(name: "my-team")
    team2 = Team.create(name: "my-other-team")

    create_test_session_with_fake_auth
    patch service_path(service), params: { service: {
      name: name,
      team_ids: [team1.id, team2.id],
    }}

    service = Service.find_by_name(name)
    assert_equal service.name, name
    assert_equal service.teams, [team1, team2]
  end
end
