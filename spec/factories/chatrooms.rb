FactoryGirl.define do

	factory :chatroom do
		name "default"

		factory :programming do
			name 'programmming'
		end

		factory :testing do
			name 'testing'
		end
	end
end