module AdsService
  module Rpc
    module Api
      def return_user_data(ad, user_id)
        payload = { ad: ad, user_id: user_id }.to_json
        publish(payload, type: 'return_user_data')
      end
    end
  end
end
