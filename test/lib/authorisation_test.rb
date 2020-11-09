require "test_helper"

class RotasAuthorisationTest < ActiveSupport::TestCase
  test "valid" do
    assert Rotas::Authorisation.email_authorised?("valid@digital.cabinet-office.gov.uk")
  end

  test "invalid gov" do
    assert_not Rotas::Authorisation.email_authorised?("invalid@culture.gov.uk")
  end

  test "invalid nongov" do
    assert_not Rotas::Authorisation.email_authorised?("someone@gmail.com")
  end

  test "invalid random" do
    assert_not Rotas::Authorisation.email_authorised?("asdf")
  end

  test "is_admin?" do
    assert Rotas::Authorisation.is_admin?("ALEX.MONK@digital.cabinet-office.gov.uk")
    assert_not Rotas::Authorisation.is_admin?("bad.person@suspicious.com")
  end
end
