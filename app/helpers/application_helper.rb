module ApplicationHelper
  def namespace
    name = controller.class.name.gsub(/(::)?\w+Controller$/, '').downcase
    return 'admin' if name == 'admin'
    return 'host' if name == 'host'
    return 'application'
  end

  def body_class
    "#{controller_name} #{action_name}"
  end

  def resource_name
    if namespace == 'admin'
      :admin
    elsif namespace == 'host'
      :host
    else
      :user
    end
  end

  def resource
    if namespace == 'admin'
      @resource ||= Admin.new
    elsif namespace == 'host'
      @resource ||= Host.new
    else
      @resource ||= User.new
    end
  end

  def resource_class
    if namespace == 'admin'
      Admin
    elsif namespace == 'host'
      Host
    else
      User 
    end
  end

  def devise_mapping
    if namespace == 'admin'
      @devise_mapping ||= Devise.mappings[:admin]
    elsif namespace == 'host'
      @devise_mapping ||= Devise.mappings[:host]
    else
      @devise_mapping ||= Devise.mappings[:user]
    end
  end
end
