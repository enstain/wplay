require File.expand_path('../boot', __FILE__)

require 'devise'
require 'carrierwave'
require 'carrierwave/mongoid'
require "action_controller/railtie"
require "action_mailer/railtie"
require "sprockets/railtie"

if defined?(Bundler)
  Bundler.require(:default, :assets, Rails.env)
end

module Wplay
  class Application < Rails::Application
    config.encoding = "utf-8"
    config.time_zone = 'Moscow'
    config.i18n.default_locale = :ru
    config.i18n.enforce_available_locales = false
    I18n.enforce_available_locales = false
    config.filter_parameters += [:password]
    config.active_support.escape_html_entities_in_json = true
    config.assets.enabled = true
    config.assets.version = '1.0'
    config.autoload_paths << Rails.root.join('lib')
  end
end
