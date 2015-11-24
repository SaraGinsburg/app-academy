class Reply < ActiveRecord::Base
  validates :body, :tweet_id, presence: true

end
