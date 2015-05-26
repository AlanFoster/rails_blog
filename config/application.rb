require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module RailsBlog
  class Application < Rails::Application
    config.assets.paths << Rails.root.join('public', 'assets', 'javascripts')
    config.assets.paths << Rails.root.join('public', 'assets', 'stylesheets')
    config.assets.paths << Rails.root.join('node_modules', 'highlight.js', 'styles')
  end
end
