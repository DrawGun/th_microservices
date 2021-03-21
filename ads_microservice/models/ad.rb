class Ad < ActiveRecord::Base
  paginates_per 5

  validates :title, :description, :city, presence: true
end
