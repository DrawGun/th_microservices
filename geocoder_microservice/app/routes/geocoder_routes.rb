class GeocoderRoutes < Application
  namespace '/v1' do
    post do
      geocoder_params = validate_with!(GeocoderParamsContract)

      result = Geocoder::FindCityService.call(*geocoder_params.to_h.values)

      status 200
      json meta: result.coordinates
    end
  end
end
