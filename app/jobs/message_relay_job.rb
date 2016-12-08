class MessageRelayJob < ApplicationJob
  	queue_as :default

  	def perform(message)
  		ActionCable.server.broadcast("chatrooms:#{message.chatroom.id}", {
  			message: ApplicationController.render(partial: 'messages/message', locals: {message: message}),
  			chatroom_id: message.chatroom.id
  		})
  	end
end
