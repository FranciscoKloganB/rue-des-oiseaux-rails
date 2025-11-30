require "application_system_test_case"
require "action_view/record_identifier"

class AdminInvitationCodesTest < ApplicationSystemTestCase
  include ActionView::RecordIdentifier

  setup do
    InvitationCode.delete_all
  end

  test "creating multiple invitation codes" do
    visit admin_invitation_codes_url

    fill_in "Number of codes", with: 2
    click_button "Generate Codes"

    assert_text "2 invitation codes created."
    assert_selector "table tbody tr", minimum: 2
    assert_selector "table thead th", text: "Sent"
  end

  test "toggling sent status via table toggle" do
    code = InvitationCode.create!(token: "ABCDEFGHIJKL")

    visit admin_invitation_codes_url

    within "##{dom_id(code)}" do
      assert_selector ".toggle-status", text: "Unset"
      find("input.toggle").click
    end

    within "##{dom_id(code)}" do
      assert_selector ".toggle-status", text: "Sent"
    end
  end
end
