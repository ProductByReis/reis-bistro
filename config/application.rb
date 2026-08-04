require_relative "boot"

require "rails/all"

if ENV["USE_BUNDLER"] == "1"
  Bundler.require(*Rails.groups)
else
  # Explicit requires matching Gemfile (system gems / RubyInstaller)
  require "propshaft"
  require "importmap-rails"
  require "turbo-rails"
  require "stimulus-rails"
  require "tailwindcss-rails"
  require "solid_cache"
  require "solid_queue"
  require "sqlite3"
end

module ReisBistro
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 8.1

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w[assets tasks])

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # A casa é em Jundiaí. O banco guarda em UTC; a aplicação raciocina em BRT,
    # o que importa para o corte de antecedência das reservas.
    config.time_zone = "America/Sao_Paulo"

    # config.eager_load_paths << Rails.root.join("extras")
  end
end
