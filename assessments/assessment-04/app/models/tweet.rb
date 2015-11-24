class Tweet < ActiveRecord::Base
  validates :title, :body, :user_id, presence: true
  # validates :body, length: {maximum: 140, messages: ["Body is too long"]}
  belongs_to :user
  has_many :replies
end
