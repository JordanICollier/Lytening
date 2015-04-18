class UsersController < ApplicationController

  before_action :set_user
  respond_to :html, :json

  def set_user
    @user = User.find(params[:id])
  end

  def show
    
  end

end
