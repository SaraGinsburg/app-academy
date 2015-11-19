require 'action_view'

class Cat < ActiveRecord::Base
  include ActionView::Helpers::DateHelper

  CAT_COLORS = %w(black white orange brown tabby grey hairless merle oreo purple blue)

  belongs_to :owner,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: 'User'


  has_many(
    :rental_requests,
    class_name: "CatRentalRequest",
    dependent: :destroy
  )

  validates(
    :birth_date,
    :color,
    :name,
    :sex,
    presence: true
  )

  validates :color, inclusion: CAT_COLORS
  validates :sex, inclusion: %w(M F)
  validates :owner, presence: true

  def age
    time_ago_in_words(birth_date)
  end
end
