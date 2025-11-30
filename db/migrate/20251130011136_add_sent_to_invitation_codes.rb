class AddSentToInvitationCodes < ActiveRecord::Migration[8.1]
  def change
    add_column :invitation_codes, :sent, :boolean, default: false, null: false
  end
end
