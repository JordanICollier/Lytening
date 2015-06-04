class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_user!

  def after_sign_in_path_for(resource)
    if current_user.num_type == 1
      "/step_one"
    elsif current_user.num_type == 2
      "/step_two"
    elsif current_user.num_type == 3
      "/step_three"
    elsif current_user.num_type == 4
      "/step_four"
    else
      "/feed"
    end
  end

end
