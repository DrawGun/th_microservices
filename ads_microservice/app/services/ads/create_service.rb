module Ads
  class CreateService
    prepend BasicService

    option :ad do
      option :title
      option :description
      option :city
    end

    option :user_id
    option :geocoder_service, default: proc { build_geocoder_service }

    attr_reader :ad

    def call
      return fail!(I18n.t(:blank, scope: 'model.errors.ad.user_id')) if @user_id.blank?

      @ad = ::Ad.new(@ad.to_h)
      @ad.user_id = @user_id

      if @ad.valid?
        @ad.save
        # geocode!
      else
        fail!(@ad.errors)
      end
    end

    private

    def build_geocoder_service
      geocoder_client.new
    end

    def client_name
      Settings.clients.geocoder
    end

    def geocoder_client
      "GeocoderService::#{client_name}::Client".classify.constantize
    end

    def geocode!
      if client_name == 'Rpc'
        @geocoder_service.geocode(@ad)
      else
        data = @geocoder_service.geocode(@ad)
        Ads::UpdateService.call(@ad.id, data)
      end
    end
  end
end
