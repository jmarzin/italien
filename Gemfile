source 'https://rubygems.org'

ruby '2.1.2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.0'
gem 'puma'

# Use sqlite3 as the database for Active Record
#gem 'sqlite3'

# Use postgres as the database for Active Record
gem 'pg'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Utiliser haml pour les vues
gem 'haml-rails', '~> 0.5.3'

# Utiliser Kaminari pour la pagination
gem 'kaminari', '~> 0.15.1'

# Utiliser simple_form pour les vues
#gem 'simple_form', '~> 3.0.1'
#gem 'country_select', '~> 1.3.1'

# Utiliser Devise pour l'identification
gem 'devise'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
gem 'jquery-turbolinks', '~> 2.0.2'


# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use ActiveModel has_secure_password
gem 'bcrypt'

# Use unicorn as the app server
# gem 'unicorn'

# Use Heroku for production
gem 'rails_12factor', group: :production

# Use Capistrano for deployment
group(:development) {
  gem 'capistrano', '~> 3.1.0'
  gem 'capistrano-bundler', '~> 1.1.2'
  gem 'capistrano-rails', '~> 1.1.1'
  gem 'capistrano-rbenv', github: "capistrano/rbenv"

}

# Use debugger
# gem 'debugger', group: [:development, :test]
group(:development, :test){
  gem 'zeus', '~> 0.13.3'
  gem 'factory_girl_rails', '~> 4.4.1'
  gem 'rspec-rails', '~> 2.14.2'
}
# Outils de test
group(:test) {
  gem 'cucumber-rails', '~> 1.4.0', :require => false
  gem 'database_cleaner', '~> 1.2.0'
  gem 'launchy', '~> 2.4.2'
  gem 'simplecov', '~> 0.8.2', :require => false
  gem 'ZenTest', '~> 4.9.5'}
