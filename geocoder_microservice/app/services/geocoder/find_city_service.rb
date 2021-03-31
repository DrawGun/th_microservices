module Geocoder
  class FindCityService
    prepend BasicService

    param :title

    attr_reader :city

    def call
      @city = City.find_by(title: title) if City.where(title: title).exists?
    end

    def coordinates
      return nil if @city.blank?

      [@city.lat, @city.lon]
    end
  end
end
