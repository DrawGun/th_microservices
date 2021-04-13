require_relative 'config/environment'

use Rack::Ougai::LogRequests, Application.logger

map '/geocode' do
  run GeocoderRoutes
end
