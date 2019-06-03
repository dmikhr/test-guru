require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module TestGuru
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # задаем часовой пояс
    # ищем название зоны через консоль
    # rails c
    # include ActiveSupport
    # TimeZone.all.select {|zone| zone.name.include? 'Moscow'}
    config.time_zone = 'Moscow'
    # язык
    # задаем :ru вместо стандартного ru-RU согласно pragmatic approach
    # https://guides.rubyonrails.org/i18n.html
    config.i18n.available_locales = [:ru, :en]
    # сменил пока локаль на :en, чтобы могли выводиться стандартные flash сообщения от Devise
    config.i18n.default_locale = :en

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
