class InvitationCode < ApplicationRecord
  validates :token, presence: true, uniqueness: true

  # Attempts to soft delete a record identified by token.
  def self.update_one_by_token(token)
    record = find_by(token: token)

    return false if record.nil? || record.deleted_at.present?

    record.update(deleted_at: Time.current)

    true
  end
end
