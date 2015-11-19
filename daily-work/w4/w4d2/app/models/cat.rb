require 'date'

class Cat < ActiveRecord::Base
  has_many :rental_requests,
    primary_key: :id,
    foreign_key: :cat_id,
    class_name: "CatRentalRequest",
    dependent: :destroy #when we kill a cat, we kill its requests

  def self.colors
    ["black", "white", "grey", "calico", "orange", "tabby"]
  end

  validates :birth_date, :color, :name, :sex, :description,
    presence: true
  validates :color, inclusion: { in: colors,
    message: "%{value} is not a valid cat color!" }
  validates :sex, inclusion: { in: %w(M F),
    message: "%{value} is not a valid cat sex!" }

  def age
    ((Date.today - birth_date).to_f / 365).to_f
  end
end
