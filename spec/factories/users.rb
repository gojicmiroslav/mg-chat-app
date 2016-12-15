FactoryGirl.define do
  	factory :user do
  		username Faker::Internet.user_name
		sequence(:email){ |n| "email#{n}@email.com"}    
		password "secretsecret"
  	end
end
