source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

gem 'bootstrap', '>= 4.3.1'
gem 'devise', '~> 4.7'
gem 'devise-bootstrap-views', '~> 1.0'
gem 'devise_invitable', '~> 2.0.0'
gem 'image_processing', '~> 1.2'
gem 'jbuilder', '~> 2.5'
gem 'jquery-rails'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '>= 3.12.4'
gem 'pundit'
gem 'rails', '~> 6.0.0'
gem 'sass-rails', '~> 5'
gem 'turbolinks', '~> 5'
gem 'webpacker', '~> 4.0'

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

gem 'ajax-datatables-rails'
gem 'awesome_print'
gem 'aws-sdk-s3', require: false
gem 'draper'
gem 'factory_bot_rails'
gem 'faker'
gem 'mailjet'
gem 'passpartu'
gem 'r_creds'
gem 'redis'
gem 'sidekiq'
gem 'slack-ruby-client'
gem 'slim-rails'

gem 'bootsnap', '>= 1.4.2', require: false

# DEPENDENCIES
gem 'nokogiri', '>= 1.10.8'
gem 'rack', '>= 2.0.8'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'dotenv'
end

group :development do
  gem 'brakeman'
  gem 'bullet'
  gem 'capistrano',         require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano-rails',   require: false
  gem 'capistrano-rvm',     require: false
  gem 'capistrano-yarn'
  # --- Optional --- #
  # allows to modify custom settings on a fly )
  gem 'capistrano-sidekiq'
  gem 'capistrano3-puma',   require: false
  # if you want "localhost" deployment.
  gem 'capistrano-locally', require: false
  gem 'letter_opener'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'rubocop'
  gem 'rubycritic'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'database_cleaner'
  gem 'fakeredis'
  gem 'rspec-rails'
  gem 'rspec-sidekiq'
  gem 'vcr'
  gem 'webmock'
end
