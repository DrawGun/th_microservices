module Ads
  class UpdateCoordinatesService
    prepend BasicService

    option :ad

    def call
      return if coordinates.blank?

      lat, lon = coordinates

      @ad.update({
        lat: lat,
        lon: lon
      })
    end

    private

    def geocoder_client
      @geocoder_client ||= GeocoderService::Client.new
    end

    def coordinates
      return @coordinates if defined?(@coordinates)

      @coordinates = geocoder_client.geocode(ad.city)
    end
  end
end
