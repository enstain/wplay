# Load the rails application
require File.expand_path('../application', __FILE__)
require 'devise'
require 'carrierwave/mongoid'

SubdomainFu.configure do |config|
  config.tld_sizes = { :development => 1,
                          :test => 0,
                          :production => 3 }
  config.override_only_path = true
end

# Initialize the rails application
Wplay::Application.initialize!
