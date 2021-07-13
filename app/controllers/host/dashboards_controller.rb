class Host::DashboardsController < HostController

  def show
    @listings = current_host.listings
    @pending_bookings = current_host.bookings.pending
    @confirmed_bookings = current_host.bookings.paid
    @cancelled_bookings = current_host.bookings.cancelled
  end

  def edit
  end

  def pending_bookings
    @pending_bookings = current_host.bookings.pending
  end

  def confirmed_bookings
    @confirmed_bookings = current_host.bookings.paid
  end

  def cancelled_bookings
    @cancelled_bookings = current_host.bookings.cancelled
  end

  # def update
  #   if current_host&.valid_password?(params[:host][:password])
  #     current_host.update(host_params)
      
  #     if current_host.save
  #       redirect_to dashboard_host_path(current_host), notice: 'host profile was successfully updated.'
  #     else
  #       render :edit
  #     end
  #   else
  #     redirect_to edit_dashboard_host_path(current_host), alert: 'Password incorrect'
  #   end
  # end

  # private
  #   def host_params
  #     params.require(:host).permit(:fullname, :username, :birth_date, :avatar)
  #   end
end