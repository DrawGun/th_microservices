require 'csv'
require_relative '../../config/environment'

namespace :db do
  task seeds: :settings do
    data_path = File.expand_path("../../../db/data/city.csv", __FILE__)
    CSV.read(data_path, headers: true).inject({}) do |result, row|

      city_params = {
        city_name: row['city'],
        lat: row['geo_lat'].to_f,
        lon: row['geo_lon'].to_f
      }

      City.create!(city_params)
    end
  end
end
