class GeocoderParamsContract < Dry::Validation::Contract
  params do
    required(:city_name).filled(:string)
  end
end
