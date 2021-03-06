module AuthService
  module Rpc
    module Api
      def auth(token)
        payload = { token: token}.to_json
        publish(payload, type: 'auth')
      end
    end
  end
end
