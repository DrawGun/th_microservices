module AdsService
  module Rpc
    module Api
      def update_user_id(user_id)
        payload = { user_id: user_id }.to_json
        publish(payload, type: 'update_ad')
      end
    end
  end
end
