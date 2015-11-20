class Album < ActiveRecord::Base

  RECORDING_LOCALES = %w(live studio)

  validates :title, :band_id, :recording_locale, presence: true
  validates :recording_locale, inclusion: { in: RECORDING_LOCALES,
    message: "%{value} is not a valid recording location (must be
    live or in studio)"}

  belongs_to :band
  has_many :tracks, dependent: :destroy


end
