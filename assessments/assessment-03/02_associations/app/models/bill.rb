# == Schema Information
#
# Table name: bills
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  author_id  :integer
#  created_at :datetime
#  updated_at :datetime
#

class Bill < ActiveRecord::Base
  belongs_to :author,
    primary_key: :id,
    foreign_key: :author_id,
    class_name: "Senator"

  has_one :sponsoring_party,
    through: :author,
    source: :party

  has_many :endorsements,
    primary_key: :id,
    foreign_key: :bill_id,
    class_name: "BillEndorsement"

  has_many :endorsing_senators,
    through: :endorsements,
    source: :senator

end
