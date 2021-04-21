# require_relative '../../config/environment'

# namespace :db do
#   desc 'Run database migrations'
#   task seeds: :settings do
#     Sequel.connect(Settings.db.url || Settings.db.to_hash) do |db|
#       db[:user_sessions].delete
#       db[:users].delete

#       user_one = User.create({ name: 'User_1', email: 'user_one@example.com', password: 'givemeatoken_one' })
#       UserSession.create({ user_id: user_one.id, uuid: SecureRandom.hex })

#       user_two = User.create({ name: 'User_2', email: 'user_two@example.com', password: 'givemeatoken_two' })
#       UserSession.create({ user_id: user_two.id, uuid: SecureRandom.hex })
#     end
#   end
# end
