class CreateInvitationCodes < ActiveRecord::Migration[8.1]
  def change
    create_table :invitation_codes do |t|
      t.boolean :sent, null: false, default: false
      t.string :token, null: false
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :invitation_codes, :token, unique: true
  end
end
