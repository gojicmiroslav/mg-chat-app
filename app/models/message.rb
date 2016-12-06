class Message < ApplicationRecord
  belongs_to :chatroom
  belongs_to :user

  scope :recent_messages, -> { order(created_at: :desc).limit(100).reverse }
end
