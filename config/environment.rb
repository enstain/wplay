# Load the rails application
require File.expand_path('../application', __FILE__)
require 'devise'
require 'carrierwave/mongoid'

# Initialize the rails application
Wplay::Application.initialize!
