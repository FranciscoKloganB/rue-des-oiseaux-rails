require "test_helper"

class InvitationCodeTest < ActiveSupport::TestCase
  test "generate_token returns uppercase alphanumeric string" do
    token = InvitationCode.generate_token

    assert_equal 12, token.length
    assert_match(/\A[A-Z0-9]{12}\z/, token)
  end

  test "toggle_sent! flips the sent flag" do
    code = invitation_codes(:alpha)

    refute_predicate code, :sent?

    code.toggle_sent!
    assert_predicate code.reload, :sent?

    code.toggle_sent!
    refute_predicate code.reload, :sent?
  end
end
