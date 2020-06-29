require 'test_helper'

class ServiceTest < ActiveSupport::TestCase
  test 'service has non-empty name' do
    assert_not Service.new(name: '').valid?
  end

  test 'service can have empty description' do
    assert Service.new(name: 'my-service', description: '').valid?
  end

  test 'service can have empty documentation' do
    assert Service.new(name: 'my-service', documentation: '').valid?
  end

  test 'service without documentation or description receives a score of 0' do
    s = Service.new(
      name: 'my-sad-service',
      description: '',
      documentation: '',
    )

    assert_equal s.score, 0
  end

  test 'service with documentation and description receives a score of 5' do
    s = Service.new(
      name: 'my-happy-service',
      description: 'my-happy-service is described',
      documentation: 'my-happy-service is documented',
    )

    assert_equal s.score, 5
  end
end
