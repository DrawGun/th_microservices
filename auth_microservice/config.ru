require_relative 'config/environment'

map '/signup' do
  run UserRoutes
end

map '/login' do
  run UserSessionRoutes
end

map '/auth' do
  run AuthRoutes
end
