require 'test_helper'

class TeamTest < ActiveSupport::TestCase
  test 'team has non-empty name' do
    assert_not Team.new(name: '').valid?
  end
end
