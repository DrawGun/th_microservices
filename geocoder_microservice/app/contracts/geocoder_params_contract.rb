class GeocoderParamsContract < Dry::Validation::Contract
  params do
    required(:title).filled(:string)
  end
end
