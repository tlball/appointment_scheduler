source 'https://rubygems.org'

# Read straight from the `.ruby-version` file to stay in sync
ruby File.read('.ruby-version').chomp

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.1.0'

# Use sqlite3 as the database for Active Record
gem 'sqlite3', '~> 1.4'

# Use Puma as the app server
gem 'puma', '~> 5.0'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem 'rack-cors'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Use RSpec for testing
  gem 'rspec-rails', '~> 4.0.1'
end

group :development do
  gem 'listen', '~> 3.3'
end

group :test do
  # Generate factories for specs
  gem 'factory_bot_rails'

  # Generate fake spec data
  gem 'ffaker'
end
