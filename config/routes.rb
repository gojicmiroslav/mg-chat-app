Rails.application.routes.draw do
	root to: "welcome#index"

	resources :chatrooms do
		resource :chatroom_users
		resources :messages
	end
 
  	devise_for :users
end
