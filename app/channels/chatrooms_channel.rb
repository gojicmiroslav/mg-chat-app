# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class ChatroomsChannel < ApplicationCable::Channel
  	def subscribed
    	# stream_from "some_channel"
    	current_user.chatrooms.each do |chatroom|
    		stream_from "chatroom:#{chatroom.id}"
    	end
  	end

  	def unsubscribed
    	stop_all_streams
  	end
end
