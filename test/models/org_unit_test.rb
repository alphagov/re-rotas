require "test_helper"

class OrgUnitTest < ActiveSupport::TestCase
  test "org-unit has non-empty name" do
    assert_not OrgUnit.new(name: "").valid?
    assert OrgUnit.new(name: "my-org-unit").valid?
  end
end
