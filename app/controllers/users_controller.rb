class UsersController < ApplicationController

  before_action :set_user
  respond_to :html, :json



  def show

  end

private
  def set_user
    @user = User.find(params[:id])
  end
end
