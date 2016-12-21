class ChatroomUser < ApplicationRecord
  	belongs_to :chatroom
  	belongs_to :user

  	def show_unread_messages?(message)
  		if last_read_at.nil?
  			return false
  		else
  			@chatroom_user.last_read_at < message.created_at
  		end
  				
  	end
end
