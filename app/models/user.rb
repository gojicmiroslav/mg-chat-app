class User < ApplicationRecord
  	# Include default devise modules. Others available are:
  	# :confirmable, :lockable, :timeoutable and :omniauthable
  	devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  	has_many :chatroom_users
  	has_many :chatrooms, through: :chatroom_users
  	has_many :messages

  	def self_chatrooms
  		ret_arr = []
  		Chatroom.all.each do |chatroom|
  			if id == chatroom.user_id
  				ret_arr << chatroom
  			end
  		end

  		ret_arr
  	end
end
