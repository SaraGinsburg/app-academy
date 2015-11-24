class Link < ActiveRecord::Base
  validates :title, :url, presence: true

  has_many :comments
end
