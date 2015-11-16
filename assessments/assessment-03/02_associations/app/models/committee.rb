# == Schema Information
#
# Table name: committees
#
#  id             :integer          not null, primary key
#  name           :string(255)
#  mandate        :string(255)
#  chairperson_id :integer
#  created_at     :datetime
#  updated_at     :datetime
#

class Committee < ActiveRecord::Base

  has_many :memberships,
    primary_key: :id,
    foreign_key: :committee_id,
    class_name: "CommitteeMembership"

  has_many :senators,
    through: :memberships,
    source: :senator

  belongs_to :chairperson,
    primary_key: :id,
    foreign_key: :chairperson_id,
    class_name: "Senator"

end
