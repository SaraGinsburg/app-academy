require 'date'

class Cat < ActiveRecord::Base
  validates :birth_date, :color, :name, :sex, :description,
    pesence: true
  validates :color, inclusion { in: %w(black white grey calico
    orange tabby), message: "%{value} is not a valid cat color" }
  validates :sex, inclusion { in: %w(M F),
    message: "%{value} is not a valid cat sex" }

  def age
    (Date.today - birth_date) / 365
  end
end
