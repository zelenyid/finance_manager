class Account < ApplicationRecord
  has_many :records, dependent: :nullify
  has_many :sent, foreign_key: 'sender_id', class_name: 'Transfer', dependent: :nullify
  has_many :received, foreign_key: 'receiver_id', class_name: 'Transfer', dependent: :nullify
  belongs_to :user

  def transfers
    sent + received
  end
end
