# == Schema Information
#
# Table name: bill_endorsements
#
#  id         :integer          not null, primary key
#  bill_id    :integer
#  senator_id :integer
#  created_at :datetime
#  updated_at :datetime
#

class BillEndorsement < ActiveRecord::Base
  belongs_to :senator,
    primary_key: :id,
    foreign_key: :senator_id,
    class_name: "Senator"
end
