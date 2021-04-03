namespace :db do
  desc 'Run database migrations'
  task seed: :settings do
    require 'sequel'

    Sequel.connect(Settings.db.to_hash) do |db|
      db[:ads].delete

      time = Time.now
      records = [
        { city: 'City 1', title: 'Title 1', description: 'Description 1', user_id: 1, created_at: time, updated_at: time },
        { city: 'City 2', title: 'Title 2', description: 'Description 2', user_id: 2, created_at: time, updated_at: time },
        { city: 'City 3', title: 'Title 3', description: 'Description 3', user_id: 1, created_at: time, updated_at: time },
        { city: 'City 4', title: 'Title 4', description: 'Description 4', user_id: 2, created_at: time, updated_at: time },
        { city: 'City 5', title: 'Title 5', description: 'Description 5', user_id: 1, created_at: time, updated_at: time },
      ]

      db[:ads].multi_insert(records)
    end
  end
end
