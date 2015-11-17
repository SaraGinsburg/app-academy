class Contact < ActiveRecord::Base
  validates :name, :email, :user_id, presence: true
  validates :user_id, :uniqueness => {:scope => :email }

  belongs_to :owner,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: "User"

  has_many :contact_shares, dependent: :destroy,
    primary_key: :id,
    foreign_key: :contact_id,
    class_name: "ContactShare"

  has_many :shared_users,
    through: :contact_shares,
    source: :user

end
