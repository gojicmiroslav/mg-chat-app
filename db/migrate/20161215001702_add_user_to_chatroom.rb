class AddUserToChatroom < ActiveRecord::Migration[5.0]
  	def change
  		add_reference :chatrooms, :user, index: true, foreign_key: true
  	end
end
