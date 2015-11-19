class CatRentalRequest < ActiveRecord::Base

  belongs_to :cat,
    primary_key: :id,
    foreign_key: :cat_id,
    class_name: "Cat"

  def self.statuses
    ["PENDING", "APPROVED", "DENIED"]
  end

  validates :cat_id, :start_date, :end_date, :end_date, :status,
    presence: true
  validates :status, inclusion: { in: statuses,
    message: "%{value} is not a valid rental status!"}
  validate :no_overlapping_approved_requests

  def no_overlapping_approved_requests
    approved_requests_on_same_cat.none? do |other_request|
      overlapping_requests(other_request)
    end
  end

  private
  def overlapping_requests(other_request)
    return false unless self.cat_id == other_request.cat_id

    [self.start_date, self.enrailsd_date].any? do |date|
      date.between?(other_request.start_date, other_request.end_date)
    end
  end

  def approved_requests_on_same_cat
    requests = self.cat.rental_requests
    requests.select { |request| request.status == "APPROVED" }
  end

end
