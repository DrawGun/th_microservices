module GeocoderService
  module Http
    module Api
      def geocode(city_name, version: 'v1')
        response = connection.post("/geocode/#{version}") do |request|
          request.params = { city_name: city_name }
        end

        response.body.dig('meta')
      end
    end
  end
end
