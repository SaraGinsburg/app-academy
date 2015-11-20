class Track < ActiveRecord::Base
  TRACK_TYPE = %w(regular bonus)

  validates :title, :album_id, :track_type, presence: true
  validates :track_type, inclusion: { in: TRACK_TYPE,
    message: "%{value} is not a valid recording location (must be
    live or in studio)"}

    belongs_to :album
    has_one :band,
      through: :album,
      source: :band
    has_many :notes
end
