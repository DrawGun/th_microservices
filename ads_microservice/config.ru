require 'rubygems'
require 'bundler'
Bundler.require

require_relative './config/application'
require_relative 'app'

run App
