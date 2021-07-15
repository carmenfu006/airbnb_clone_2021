class PagesController < ApplicationController
  def home
    @listings = Listing.is_available.order("RANDOM()").limit(3)
  end

  def host_homepage
  end
end