RSpec.configure do |config|
	Shoulda::Matchers.configure do |config|
	  config.integrate do |with|
	    with.test_framework :rspec
	    with.library :rails
	  end
	end

	config.include(Shoulda::Matchers::ActiveModel, type: :model)
end