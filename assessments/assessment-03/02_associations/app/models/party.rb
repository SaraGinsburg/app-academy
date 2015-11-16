# == Schema Information
#
# Table name: parties
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  color           :string(255)
#  ideology_id     :integer
#  party_leader_id :integer
#  created_at      :datetime
#  updated_at      :datetime
#

class Party < ActiveRecord::Base
  has_many :senators,
    primary_key: :id,
    foreign_key: :party_id,
    class_name: "Senator"

  belongs_to :party_leader,
    primary_key: :id,
    foreign_key: :party_leader_id,
    class_name: "Senator"

  belongs_to :ideology,
    primary_key: :id,
    foreign_key: :ideology_id,
    class_name: "Ideology"

end
