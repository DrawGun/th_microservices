module GeocoderService
  module Rpc
    module Api
      def geocode(ad)
        payload = { id: ad.id, city: ad.city }.to_json
        publish(payload, type: 'geocode')
      end
    end
  end
end
