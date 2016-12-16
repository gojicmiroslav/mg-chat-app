require 'rails_helper'

RSpec.describe Chatroom, type: :model do
	it { should validate_presence_of(:name) }
	it { should have_many :chatroom_users }
	it { should have_many(:users).through(:chatroom_users) }
	it { should have_many :messages }

	describe "custom methods" do
		let(:user){ FactoryGirl.create(:user) }
		let(:other_user){ FactoryGirl.create(:user) }
		let!(:default){ FactoryGirl.create(:chatroom, user: user) }
		let!(:programming){ FactoryGirl.create(:programming, user: user) }
		let!(:testing){ FactoryGirl.create(:testing, user: other_user) }

		it "returns users chatrooms" do
			expect(Chatroom.get_chatrooms_for(user)).to match([default, programming])
		end
	end
end