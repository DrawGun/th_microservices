require 'spec_helper'
require 'pry'
require 'rack/test'
require 'rubygems'
require 'bundler'

ENV['RACK_ENV'] ||= 'test'

Bundler.require

Dir['./spec/support/**/*.rb'].sort.each { |f| require f }

require_relative '../config/application'
require_relative '../app'

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.include RackHelpers, type: :request
end
