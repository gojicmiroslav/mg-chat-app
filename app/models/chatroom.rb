class Chatroom < ApplicationRecord
	belongs_to :user
	has_many :chatroom_users
	has_many :users, through: :chatroom_users
	has_many :messages 

	validates :name, presence: true 

	scope :recent_messages, -> { messages.order(created_at: :desc).limit(100).reverse }
	scope :get_chatrooms_for, ->(user_id) { where('user_id = ?', user_id) }

	def is_owner?(user)
		users.include?(user)
	end
end
