class Users::SessionsController < Devise::SessionsController
  # Force remember_me on every login so PWA users never have to log in again
  def create
    params[:user][:remember_me] = "1"
    super
  end
end
