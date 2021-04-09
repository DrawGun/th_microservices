module GeocoderService
  module Http
    module Api
      def geocode(ad, version: 'v1')
        response = connection.post("/geocode/#{version}") do |request|
          request.params = { city_name: ad.city }
        end

        response.body.dig('meta')
      end
    end
  end
end
