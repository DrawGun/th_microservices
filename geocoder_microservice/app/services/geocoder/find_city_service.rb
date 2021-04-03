module Geocoder
  class FindCityService
    prepend BasicService

    param :city_name

    attr_reader :city

    def call
      @city = City.find_by(city_name: city_name) if City.where(city_name: city_name).exists?
    end

    def coordinates
      return if @city.blank?

      [@city.lat, @city.lon]
    end
  end
end
