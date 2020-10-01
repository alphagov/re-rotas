require "test_helper"

# class ApplicationControllerTest < ActionDispatch::IntegrationTest
class ApplicationControllerTest < ActionController::TestCase
  test "people finder links are approximately okay" do
    emails = %w[
      firstname.lastname1@digital.cabinet-office.gov.uk
      firstname.middlenamelastname-lastname@digital.cabinet-office.gov.uk
    ]
    slugs = %w[firstname-lastname1 firstname-middlenamelastname-lastname]

    emails.zip(slugs).each do |email, slug|
      url = "https://peoplefinder.cabinetoffice.gov.uk/people/#{slug}"
      assert_equal @controller.send(:people_finder_url, email), url
    end
  end

  test "name_fmt works" do
    emails = %w[
      firstname.lastname1@digital.cabinet-office.gov.uk
      firstname.middlenamelastname-lastname@digital.cabinet-office.gov.uk
    ]
    nices = ["Firstname", "Firstname"]

    emails.zip(nices).each do |email, nice|
      assert_equal @controller.send(:name_fmt, email), nice
    end
  end

  test "email_fmt works" do
    emails = %w[
      firstname.lastname1@digital.cabinet-office.gov.uk
      firstname.middlenamelastname-lastname@digital.cabinet-office.gov.uk
    ]
    nices = ["Firstname Lastname", "Firstname Middlenamelastname-lastname"]

    emails.zip(nices).each do |email, nice|
      assert_equal @controller.send(:email_fmt, email), nice
    end
  end
end
