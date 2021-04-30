require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Myapp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    config.enable_dependency_loading = true

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    # Prevent initializing the application before assets are precompiled (required for heroku) 
    config.assets.initialize_on_precompile = false 
    # Add Rails Admin assets (required) 
    config.assets.precompile += ['rails_admin/rails_admin.css', 'rails_admin/rails_admin.js']
  end
end
