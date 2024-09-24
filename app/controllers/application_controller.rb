class ApplicationController < ActionController::Base

  def after_sign_in_path_for(resource)
    if resource.is_a?(Admin)
      admin_dashboard_path
    elsif resource.is_a?(User)
      root_path
    else
      super
    end
  end

  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :admin
      new_admin_session_path
    else
      new_user_session_path
    end
  end
end
