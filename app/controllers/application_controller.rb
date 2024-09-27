class ApplicationController < ActionController::Base
  # before_action :ensure_single_session


  def after_sign_in_path_for(resource)
    if resource.is_a?(Admin)
      sign_out(:user) if user_signed_in?
      admin_dashboard_path
    elsif resource.is_a?(User)
      sign_out(:admin) if admin_signed_in?
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

  private

end
