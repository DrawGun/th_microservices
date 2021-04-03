require_relative 'config/environment'

map '/geocode' do
  run GeocoderRoutes
end
