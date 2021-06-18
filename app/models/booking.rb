class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :listing

  delegate :host, to: :listing

  after_create :generate_ref_no
  after_create :calculate_total

  enum status: [:pending, :paid, :cancelled]

  def calculate_total
    days_between = (check_out_date.to_date - check_in_date.to_date).to_i
    total_days = days_between + 1
    self.total = listing.price_per_day * total_days
    self.save
  end

  def generate_ref_no
    randomstring = SecureRandom.hex(3)
    self.ref_no = randomstring
    self.save
  end
end