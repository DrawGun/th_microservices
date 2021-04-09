module AdsService
  module Rpc
    module Api
      def update_coordinates(id, coordinates)
        payload = { id: id, coordinates: coordinates }.to_json
        publish(payload, type: 'update_coordinates')
      end
    end
  end
end
