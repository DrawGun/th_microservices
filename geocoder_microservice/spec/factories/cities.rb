FactoryBot.define do
  factory :city do
    title { generate(:title) }

    lat { 55.7540471 }
    lon { 37.620405 }
  end
end
