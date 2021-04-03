class City
  include Mongoid::Document

  field :city_name, type: String
  field :lat, type: Float
  field :lon, type: Float
end
