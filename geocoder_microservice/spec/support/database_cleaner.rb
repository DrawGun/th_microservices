RSpec.configure do |config|
  config.before(:suite) do
    # DatabaseCleaner.strategy = :transaction
    DatabaseCleaner[:mongoid].strategy = :deletion
    DatabaseCleaner.clean_with(:deletion)
  end

  config.before(:all) do
    DatabaseCleaner.start
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning { example.run }
  end

  config.after(:all) do
    DatabaseCleaner.clean
  end
end


