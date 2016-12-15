require 'rails_helper'

feature 'Home page' do
	let(:user){ FactoryGirl.create(:user) }
	let!(:default){ FactoryGirl.create(:chatroom, user: user)}
	let!(:programming){ FactoryGirl.create(:programming, user: user)}
	let!(:testing){ FactoryGirl.create(:testing, user: user)}

	scenario 'welcome message' do
		visit "/"

		expect(page).to have_content("Welcome to Chat App")
		expect(page).to have_link("Chat", href: chatrooms_path)
	end

	context "Guet User" do
		scenario "cannot visit chatrooms" do
			visit "/"
			click_on("Chat")
			expect(page).to have_content("Log in")
		end

		scenario "cannot create chatroom" do
			visit "/"
			click_on("Create Chatroom")
			expect(page).to have_content("Log in")
		end

		scenario "does not show chatrooms" do
			visit '/'
			expect(page).not_to have_content(default.name)
			expect(page).not_to have_content(programming.name)
			expect(page).not_to have_content(testing.name)
		end
	end

	context "Authenticated user" do	
		before do
 			login_as(user, :scope => :user)
 		end

		scenario "show username" do
			visit "/"

			expect(page).not_to have_content("Log In")
			expect(page).not_to have_content("Register")
			expect(page).to have_content(user.username)
		end

		scenario "show chatrooms" do
			visit '/'
			expect(page).to have_content(default.name)
			expect(page).to have_content(programming.name)
			expect(page).to have_content(testing.name)
		end
	end

end