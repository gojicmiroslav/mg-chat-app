require 'rails_helper'

RSpec.describe User, type: :model do
	it { should have_many :chatroom_users }
	it { should have_many(:chatrooms).through(:chatroom_users) }
	it { should have_many :messages }
end