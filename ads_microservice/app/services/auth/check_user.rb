module Auth
  class CheckUser
    prepend BasicService

    option :token
    option :auth_service, default: proc { build_auth_service }

    attr_reader :user_id

    def call
      response = auth_service.auth(token)

      @user_id = case client_name
      when 'Rpc'
        auth_service.response
      else
        response['user_id']
      end
    end

    private

    def build_auth_service
      "AuthService::#{client_name}::Client".classify.constantize.fetch
    end

    def client_name
      Settings.clients.auth
    end
  end
end
