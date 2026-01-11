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
  end

  test "toggling sent status via table toggle" do
    code = InvitationCode.create!(token: "ABCDEFGHIJKL")

    visit admin_invitation_codes_url

    # Find the row the user wants to delete
    row = find("tr", text: code.token)

    within row do
      assert_text "Unset"

      find("input[type='checkbox']").click
    end

    within row do
      assert_text "Sent"
    end
  end

  test "filters between active and deleted invitation codes" do
    active = InvitationCode.create!(token: "ACTIVECODE01")
    InvitationCode.create!(token: "DELETEDCODE1", deleted_at: Time.current)

    visit admin_invitation_codes_url

    assert_text active.token
    refute_text "DELETEDCODE1"

    click_on "Deleted"
    assert_text "DELETEDCODE1"
    refute_text active.token

    click_on "All"
    assert_text active.token
    assert_text "DELETEDCODE1"
  end

  test "soft deleting an invitation code removes it from active list" do
    code = InvitationCode.create!(token: "TRASHCODE012")

    visit admin_invitation_codes_url

    within "tr", text: code.token do
      find("button[aria-label='Delete invitation code #{code.token}']").click
    end

    within "dialog[open]" do
      click_button "Delete"
    end

    refute_text code.token

    click_on "Deleted"
    assert_text code.token
  end
end
