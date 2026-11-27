class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_account_update_params, only: %i[update]

  protected

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name])
  end

  def update_resource(resource, params)
    return resource.update_with_password(params) if resource.provider == "email"
    resource.update_without_password(params)
  end

  def after_update_path_for(resource)
    edit_user_registration_path(resource)
  end
end
