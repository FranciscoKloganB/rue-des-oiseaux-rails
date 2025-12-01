class InvitationCode < ApplicationRecord
  TOKEN_ALPHABET = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789".freeze

  scope :active, -> { where(deleted_at: nil) }
  scope :deleted, -> { where.not(deleted_at: nil) }

  validates :token, presence: true, uniqueness: true,
                    length: { is: 12 },
                    format: { with: /\A[A-Z0-9]+\z/, message: "must use A-Z or 0-9 characters" }

  # Attempts to soft delete a record identified by token.
  def self.update_one_by_token(token)
    record = find_by(token: token)

    return false if record.nil? || record.deleted_at.present?

    record.update(deleted_at: Time.current)

    true
  end

  def self.generate_token
    Nanoid.generate(alphabet: TOKEN_ALPHABET, size: 12)
  end

  def toggle_sent!
    update!(sent: !sent)
  end

  def soft_delete!
    update!(deleted_at: Time.current)
  end
end
