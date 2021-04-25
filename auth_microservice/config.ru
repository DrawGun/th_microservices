require_relative 'config/environment'

use Rack::RequestId
use Rack::Ougai::LogRequests, Application.logger

map '/signup' do
  run UserRoutes
end

map '/login' do
  run UserSessionRoutes
end

map '/auth' do
  run AuthRoutes
end
