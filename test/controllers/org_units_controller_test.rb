require 'test_helper'
require 'helpers/auth_helper'

class OrgUnitsControllerTest < ActionDispatch::IntegrationTest
  test 'should show all org-units' do
    create_test_session_with_fake_auth
    get org_units_path
    assert_response :success
  end

  test 'should show an org-unit' do
    create_test_session_with_fake_auth
    org_unit = OrgUnit.create(name: 'my-ops-ou')
    get org_unit_path(org_unit)
    assert_response :success
    assert_select 'h1', text: 'my-ops-ou'
  end
end
