module AuthService
  module Http
    module Api
      def auth(token, version: 'v1')
        response = connection.post("/auth/#{version}") do |request|
          request.headers["Authorization"] = "Bearer #{token}"
        end

        response.body.dig('meta')
      end
    end
  end
end
