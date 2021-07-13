class ApplicationController < ActionController::Base

  def after_sign_in_path_for(resource)
    if resource.class == User
      user_path(resource)
    elsif resource.class == Host
      host_dashboard_path(resource)
    else
      root_path
    end
  end

  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :user
      root_path
    elsif resource_or_scope == :host
      host_path
    else
      root_path
    end
  end

end
