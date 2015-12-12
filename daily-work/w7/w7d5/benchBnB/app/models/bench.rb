class Bench < ActiveRecord::Base
  validates :lat, :lng, :description, presence: true
end
