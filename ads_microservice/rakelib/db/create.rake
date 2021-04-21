namespace :db do
  desc 'Run database migrations'
  task create: :settings do
    require 'sequel/core'

    database_name = Settings.db.to_hash.delete(:database)
    database_config = Settings.db.to_hash.merge('database' => 'postgres')
    Sequel.connect(Settings.db.url || database_config) do |db|
      db.execute "DROP DATABASE IF EXISTS #{database_name}"
      db.execute "CREATE DATABASE #{database_name}"
    end
  end
end
