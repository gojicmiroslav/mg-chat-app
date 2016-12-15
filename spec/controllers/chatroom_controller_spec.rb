require 'rails_helper'

RSpec.describe ChatroomsController, type: :controller do
	describe 'guest user' do
		let(:user){ FactoryGirl.create(:user) }

		describe 'GET index' do
			it 'redirects to login page' do
				get :index
				expect(response).to redirect_to(new_user_session_path)
			end
		end

		describe 'GET show' do
			let(:chatroom){ FactoryGirl.create(:chatroom, user:user) }

			it 'redirects to login page' do
				get :show, id: chatroom
				expect(response).to redirect_to(new_user_session_path)
			end
		end		

		describe 'GET new' do
			it 'redirects to login page' do
				get :new
				expect(response).to redirect_to(new_user_session_path)
			end
		end

		describe 'POST create' do
			it 'redirects to login page' do
				post :create, chatroom: FactoryGirl.attributes_for(:chatroom)
				expect(response).to redirect_to(new_user_session_path)
			end
		end

		describe 'GET edit' do
			it 'redirects to login page' do
				get :edit, id: FactoryGirl.create(:chatroom, user: user)
				expect(response).to redirect_to(new_user_session_path)
			end
		end

		describe 'PUT update' do
			it 'redirects to login page' do
				post :update, id: FactoryGirl.create(:chatroom, user: user), chatroom: { name: 'newname' }
				expect(response).to redirect_to(new_user_session_path)
			end
		end

		describe 'DELETE destroy' do
			it 'redirects to login page' do
				delete :destroy, id: FactoryGirl.create(:chatroom, user: user)
				expect(response).to redirect_to(new_user_session_path) 
			end
		end
	end

	describe 'authenticated user' do
		let(:user){ FactoryGirl.create(:user) }

		before do
			sign_in(user)
		end

		it_behaves_like 'public access to chatrooms'

		describe 'GET show' do
			let(:chatroom){ FactoryGirl.create(:chatroom, user: user) }

			it 'renders :show template' do
				get :show, id: chatroom
				expect(response).to render_template(:show)
			end

			it 'assigns requested chatroom to template' do
				get :show, id: chatroom
				expect(assigns(:chatroom)).to eq(chatroom)
			end
		end

		describe 'GET new' do
			it 'renders :new template' do
				get :new
				expect(response).to render_template(:new)
			end

			it 'assings new chatroom object to template' do
				get :new
				expect(assigns(:chatroom)).to be_a_new(Chatroom)
			end
		end

		describe 'POST create' do
			context 'valid data' do
				let(:valid_data){ FactoryGirl.attributes_for(:chatroom) }

				it 'redirects to chatroom#show' do
					post :create, chatroom: valid_data
					expect(response).to redirect_to(chatroom_path(assigns(:chatroom)))
				end

				it 'creates new chatroom in database' do
					expect {
						post :create, chatroom: valid_data
					}.to change(Chatroom, :count).by(1)
				end
			end

			context 'invalid data' do
				let(:invalid_data){ FactoryGirl.attributes_for(:chatroom, name: "") }

				it 'renders :new template' do
					post :create, chatroom: invalid_data
					expect(response).to render_template(:new)
				end

				it 'does not create new chatroom in database' do
					expect {
						post :create, chatroom: invalid_data
					}.not_to change(Chatroom, :count)

				end
			end
		end

		context 'is not owner of the chatroom' do
			let(:new_user){ FactoryGirl.create(:user) }

			describe 'GET edit' do
				it 'redirects to chatrooms page' do
					get :edit, id: FactoryGirl.create(:chatroom, user: new_user)
					expect(response).to redirect_to(chatrooms_path)
				end
			end

			describe 'PUT update' do
				it 'redirects to chatrooms page' do
					put :update, id: FactoryGirl.create(:chatroom, user: new_user),
								 chatroom: FactoryGirl.attributes_for(:chatroom)
					expect(response).to redirect_to(chatrooms_path)
				end
			end

			describe 'DELETE destroy' do
				it 'redirects to chatrooms page' do
					delete :destroy, id: FactoryGirl.create(:chatroom, user: new_user)
					expect(response).to redirect_to(chatrooms_path)
				end
			end
		end

		context 'is owner of the chatroom' do
			let(:chatroom){ FactoryGirl.create(:chatroom, user: user) }

			describe 'GET edit' do
				it 'renders :edit template' do
					get :edit, id: chatroom
					expect(response).to render_template(:edit)
				end

				it 'assigns the requested chatroom to template' do
					get :edit, id: chatroom
					expect(assigns(:chatroom)).to eq(chatroom)
				end
			end

			describe 'PUT update' do
				context "valid data" do
					let(:valid_data){ FactoryGirl.attributes_for(:chatroom, name: "New Name", user: user) }

					it 'redirects to chatroom#show action' do 
						put :update, id: chatroom, chatroom: valid_data
						expect(response).to redirect_to(chatroom_path(chatroom))
					end

					it 'update chatroom in the database' do
						put :update, id: chatroom, chatroom: valid_data
						chatroom.reload
						expect(chatroom.name).to eq("New Name")
					end
				end

				context "invalid data" do
					let(:invalid_data){ FactoryGirl.attributes_for(:chatroom, name: "", user: user) }

					it 'renders :edit template' do
						put :update, id: chatroom, chatroom: invalid_data
						expect(response).to render_template(:edit)
					end

					it 'does not update chatroom in database' do
						put :update, id: chatroom, chatroom: invalid_data
						chatroom.reload
						expect(chatroom.name).not_to eq("")
					end
				end
			end

			describe 'DELETE destroy' do
				it 'redirects to chatroom#index' do
					delete :destroy, id: chatroom
					expect(response).to redirect_to(chatrooms_path)
				end

				it 'deletes chatroom from database' do
					delete :destroy, id: chatroom
					expect(Chatroom.exists?(chatroom.id)).to be_falsy
				end
			end
		end
	end
end