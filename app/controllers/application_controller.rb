class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_user!
  before_action :setup_user!

  private

  def after_sign_in_path_for(resource)
    '/feed'
  end

  def setup_user!
    # don't do if were signed in
    return if !current_user or
      # or done with the setup
      current_user.setup_step.nil? or
      # or on the right page
      (params[:controller] == 'setup' &&
       params[:id] == current_user.setup_step.to_s) or
      SetupController.can_visit(params)
    # go to the right place
    redirect_to setup_path(current_user.setup_step)
  end

  class OverCapacity < StandardError; end
  rescue_from OverCapacity, with: :over_capacity

  class InternalServer < StandardError; end
  rescue_from InternalServer, with: :internal_server

  private

   def over_capacity
     render file: "/public/404.html", status: 404
   end

   def internal_server
     render file: "/public/500.html", status: 500
   end

end
