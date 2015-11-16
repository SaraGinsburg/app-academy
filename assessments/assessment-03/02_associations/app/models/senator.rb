# == Schema Information
#
# Table name: senators
#
#  id         :integer          not null, primary key
#  fname      :string(255)
#  lname      :string(255)
#  state      :string(255)
#  party_id   :integer
#  created_at :datetime
#  updated_at :datetime
#

class Senator < ActiveRecord::Base
  belongs_to :party,
    primary_key: :id,
    foreign_key: :party_id,
    class_name: "Party"

  has_one :ideology,
    through: :party,
    source: :ideology

  has_one :party_leader,
    through: :party,
    source: :party_leader

  has_one :desk,
    primary_key: :id,
    foreign_key: :owner_id,
    class_name: "Desk"

  has_many :committee_memberships,
    primary_key: :id,
    foreign_key: :senator_id,
    class_name: "CommitteeMembership"

  has_many :committees,
    through: :committee_memberships,
    source: :committee

  has_many :chairpersons,
    through: :committees,
    source: :chairperson

    has_one :committee_chaired,
      primary_key: :id,
      foreign_key: :chairperson_id,
      class_name: "Committee"

    has_one :party_led,
      primary_key: :id,
      foreign_key: :party_leader_id,
      class_name: "Party"



end
