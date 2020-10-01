require "test_helper"

class RotasCalendarUrlTest < ActiveSupport::TestCase
  test "valid_url_is_valid" do
    url_fragment = Rotas::CalendarUrl.generate_url(
      "skimmed.milk@digital.cabinet-office.gov.uk",
    )

    validated_email = Rotas::CalendarUrl.email_from_url_fragment(
      url_fragment,
    )
    assert_equal validated_email, "skimmed.milk@digital.cabinet-office.gov.uk"
  end

  test "invalid_url_is_invalid" do
    bogus_url_fragment = "skimmed+milk="

    assert Rotas::CalendarUrl.email_from_url_fragment(
      bogus_url_fragment,
    ).nil?
  end
end
