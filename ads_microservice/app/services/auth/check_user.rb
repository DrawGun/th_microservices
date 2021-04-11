module Auth
  class CheckUser
    prepend BasicService

    option :ad do
      option :title
      option :description
      option :city
    end

    option :token
    option :auth_service, default: proc { build_auth_service }

    def call
      set_user_id!
    end

    private

    def build_auth_service
      AuthService::Rpc::Client.new
    end

    def set_user_id!
      @auth_service.auth(@token, @ad)
    end
  end
end
