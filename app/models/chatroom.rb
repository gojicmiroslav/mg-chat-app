class Chatroom < ApplicationRecord
	has_many :chatroom_users
	has_many :users, through: :chatroom_users
	has_many :messages 

	scope :recent_messages, -> { messages.order(created_at: :desc).limit(100).reverse }
end
