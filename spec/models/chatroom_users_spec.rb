require 'rails_helper'

require 'rails_helper'

RSpec.describe ChatroomUser, type: :model do
	it { should belong_to :chatroom }
	it { should belong_to :user }
end