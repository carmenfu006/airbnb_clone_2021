class ApplicationController < ActionController::Base
  # before_action :configure_permitted_parameters, if: :devise_controller?

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

  # def configure_permitted_parameters
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:fullname, :username, :birth_date])
  # end

  def devise_parameter_sanitizer
    if resource_class == Host
      Host::ParameterSanitizer.new(Host, :host, params)
    else
      ParameterSanitizer.new(User, :user, params)
      # super # Use the default one
    end
  end
end
