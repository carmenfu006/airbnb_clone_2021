class Host::ListingsController < HostController

  def index
    @listing = Listing.new
    @listings = current_host.listings
  end

  def create
    listing = current_host.listings.create(listing_params)

    if listing.save
      redirect_to host_listings_path, notice: 'Listing was successfully created.'
    else
      redirect_to host_listings_path, notice: 'There was an error. Please try again.'
    end
  end

  def edit
    @listing = Listing.find(params[:id])
  end

  def update
    @listing = Listing.find(params[:id])
    @listing.update(listing_params)
  
    if @listing.save
      redirect_to host_listings_path, notice: 'Listing was successfully updated.'
    else
      redirect_to host_listings_path, notice: 'There was an error. Please try again.'
    end
  end

  def delete_photo_attachment
    @image = ActiveStorage::Attachment.find(params[:id])
    @image.purge
    redirect_to host_listings_path, notice: 'Photo was successfully removed.'
  end

  private
    def listing_params
      params.require(:listing).permit(:title, :description, :price_per_day, :available, :location, :latitude, :longitude, photos: [])
    end
end