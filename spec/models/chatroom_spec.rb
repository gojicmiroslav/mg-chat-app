require 'rails_helper'

RSpec.describe Chatroom, type: :model do
	it { should validate_presence_of(:name) }
	it { should have_many :chatroom_users }
	it { should have_many(:users).through(:chatroom_users) }
	it { should have_many :messages }
end