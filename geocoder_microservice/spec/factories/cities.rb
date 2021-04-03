FactoryBot.define do
  factory :city do
    city_name { generate(:city_name) }

    lat { 55.7540471 }
    lon { 37.620405 }
  end
end
