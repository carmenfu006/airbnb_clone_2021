class Dashboard::ListingsController < DashboardController

  def create
    listing = current_host.listings.create(listing_params)

    if listing.save
      redirect_to dashboard_host_path(current_host), notice: 'Listing was successfully created.'
    else
      redirect_to dashboard_host_path(current_host), notice: 'There was an error. Please try again.'
    end
  end

  def edit
    @listing = Listing.find(params[:id])
  end

  def update
    @listing = Listing.find(params[:id])
    @listing.update(listing_params)
  
    if @listing.save
      redirect_to dashboard_host_path(current_host), notice: 'Listing was successfully updated.'
    else
      redirect_to dashboard_host_path(current_host), notice: 'There was an error. Please try again.'
    end
  end

  def delete_photo_attachment
    @image = ActiveStorage::Attachment.find(params[:id])
    @image.purge
    redirect_to dashboard_host_path(current_host), notice: 'Photo was successfully removed.'
  end

  private
    def listing_params
      params.require(:listing).permit(:title, :description, :price_per_day, :location, :latitude, :longitude, photos: [])
    end

end