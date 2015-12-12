class Bench < ActiveRecord::Base
  validates :lat, :lng, :description, presence: true

  def self.in_bounds(bounds)
    # bounds in the following format:
    # {
    #   "northEast"=> {"lat"=>"37.80971", "lng"=>"-122.39208"},
    #   "southWest"=> {"lat"=>"37.74187", "lng"=>"-122.47791"}
    # }
    #... query logic goes here
    Bench.all.select do |bench|
      bench.lat.between?(
        bounds["southWest"]["lat"],
        bounds["northEast"]["lat"]
      ) && bench.lat.between?(
        bounds["northEast"]["lng"]
        bounds["southWest"]["lng"],
      )
    end

  end

end
