class WelcomeController < ApplicationController

	def index
		@chatrooms = Chatroom.all
	end

end