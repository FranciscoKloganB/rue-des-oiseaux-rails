class AddDeletedAtIndexToInvitationCodes < ActiveRecord::Migration[8.1]
  def change
    add_index :invitation_codes, :deleted_at
  end
end
