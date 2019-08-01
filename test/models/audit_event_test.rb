require 'test_helper'

class AuditEventTest < ActiveSupport::TestCase
  test 'happy path' do
    assert_empty AuditEvent.new(
      email: 'foo@bar.com',
      event: {
        message: 'did a thing'
      },
    ).errors
  end

  test 'email cannot be empty' do
    assert_empty AuditEvent.new(
      event: {
        message: 'did a thing'
      },
    ).errors
  end

  test 'event cannot be empty' do
    assert_empty AuditEvent.new(
      email: 'foo@bar.com',
    ).errors
  end
end
