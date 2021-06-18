class Listing < ApplicationRecord
  belongs_to :host
  has_many_attached :photos

  geocoded_by :location
  after_validation :geocode

  has_many :bookings
end