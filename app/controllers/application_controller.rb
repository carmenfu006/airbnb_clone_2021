class ApplicationController < ActionController::Base

  def after_sign_in_path_for(resource)
    if resource.class == User
      user_path(resource)
    else
      host_path(resource)
    end
  end

  def after_sign_out_path_for(resource)
    if resource.class == User
      root_path
    else
      platform_path
    end
  end

end
