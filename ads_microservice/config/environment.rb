# Задаем переменную окружения
ENV['RACK_ENV'] ||= 'development'

# Подключаем гемы
require 'bundler/setup'
Bundler.require(:default, ENV['RACK_ENV'])

# Подключаем проект
require_relative 'application_loader'
ApplicationLoader.load_app!
