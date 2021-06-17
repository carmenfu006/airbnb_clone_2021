class UsersController < ApplicationController
  before_action :authenticate_user!
  layout 'user'

  def show
    @listings = Listing.all
  end

  def edit
  end

  def update
    if current_user&.valid_password?(params[:user][:password])
      current_user.update(user_params)
      
      if current_user.save
        redirect_to user_path(current_user), notice: 'User profile was successfully updated.'
      else
        render :edit
      end
    else
      redirect_to edit_user_path(current_user), alert: 'Password incorrect'
    end
  end

  private
    def user_params
      params.require(:user).permit(:fullname, :username, :birth_date, :avatar)
    end
end