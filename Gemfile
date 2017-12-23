ruby "2.3.3"
source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.1'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.18'
# Use Puma as the app server
gem 'puma', '~> 3.7'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
gem 'mini_magick'
gem 'fancybox-rails'
# gem 'therubyracer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'

gem 'jquery-raty-rails', github: 'bmc/jquery-raty-rails'

# Authentication
gem 'devise'

# Heroku gems
gem 'rails_12factor', group: :production

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'rubocop'
  gem 'pry'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

#bootstrap
gem 'jquery-rails'
gem 'bootstrap-sass'
# has attached images
gem 'paperclip'

# fb omniauth
gem 'therubyracer'
gem 'omniauth-facebook'

gem 'font-awesome-rails'
# vk omniauth
gem 'omniauth-vkontakte'

# paperclip+heroku images
gem 'aws-sdk'

# add WYSAWYG text-creator
gem 'trix'
gem 'ckeditor'

# instagram omniauth
gem 'omniauth-instagram'

# paginate pages
gem 'will_paginate-bootstrap'

gem 'globalize', github: 'globalize/globalize'

# images cloud-based service that provides an end-to-end image and video management solution
gem 'carrierwave'
gem 'cloudinary'

#social shares
gem 'social-share-button'

gem 'pg_search'

gem 'google-analytics-rails', '1.1.1'

#ui kit pach
gem 'uikit2-rails', '~> 0.1.10'

# random names gem
gem 'faker', :git => 'git://github.com/stympy/faker.git', :branch => 'master'

# user interface lib
gem 'jquery-ui-rails'
gem 'elevatezoom-rails'

gem "nested_form"
gem 'nested_form_fields'

gem 'record_tag_helper', '~> 1.0'

gem 'ancestry'
gem 'acts_as_list'

gem 'meta-tags'

# ukrainian regions
gem 'ruuaby'
gem 'curb'

gem 'russian'
gem 'figaro'
