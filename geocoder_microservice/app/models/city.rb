class City
  include Mongoid::Document

  field :title, type: String
  field :lat, type: Float
  field :lon, type: Float
end
