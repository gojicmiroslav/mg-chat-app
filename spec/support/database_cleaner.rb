RSpec.configure do |config|
	config.use_transactional_fixtures = false

	#This says that before the entire test suite runs, clear the test database out completely.
  	config.before(:suite) do
    	DatabaseCleaner.clean_with(:truncation)
  	end

	config.before(:each) do
	  DatabaseCleaner.strategy = :transaction
	end

	config.before(:each, :js => true) do
	  DatabaseCleaner.strategy = :truncation
	end

	config.before(:each) do
		DatabaseCleaner.start
	end

  	config.after(:each) do
    	DatabaseCleaner.clean
  	end
end