class Dashboard::HostsController < DashboardController

  def show
    @listing = Listing.new
    @listings = current_host.listings
  end

  def edit
  end

  def update
    if current_host&.valid_password?(params[:host][:password])
      current_host.update(host_params)
      
      if current_host.save
        redirect_to dashboard_host_path(current_host), notice: 'host profile was successfully updated.'
      else
        render :edit
      end
    else
      redirect_to edit_dashboard_host_path(current_host), alert: 'Password incorrect'
    end
  end

  private
    def host_params
      params.require(:host).permit(:fullname, :username, :birth_date, :avatar)
    end
end