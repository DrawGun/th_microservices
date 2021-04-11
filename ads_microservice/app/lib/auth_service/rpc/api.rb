module AuthService
  module Rpc
    module Api
      def auth(token, ad)
        payload = { token: token, ad: ad }.to_json
        publish(payload, type: 'auth')
      end
    end
  end
end
