require 'test_helper'

class ServiceTest < ActiveSupport::TestCase
  test 'service has non-empty name' do
    assert_not Service.new(name: '').valid?
  end

  test 'service can have empty description' do
    assert Service.new(name: 'my-service', description: '').valid?
  end
end
