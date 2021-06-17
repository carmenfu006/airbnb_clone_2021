class HostsController < ApplicationController
  before_action :authenticate_host!
  layout 'platform'

  def show
  end

  def edit
  end

  def update
    if current_host&.valid_password?(params[:host][:password])
      current_host.update(host_params)
      
      if current_host.save
        redirect_to host_path(current_host), notice: 'host profile was successfully updated.'
      else
        render :edit
      end
    else
      redirect_to edit_host_path(current_host), alert: 'Password incorrect'
    end
  end

  private
    def host_params
      params.require(:host).permit(:fullname, :username, :birth_date, :avatar)
    end
end