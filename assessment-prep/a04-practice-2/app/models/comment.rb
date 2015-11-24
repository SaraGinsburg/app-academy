class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :link

  validates :user_id, :link_id, :body, presence: true
end
