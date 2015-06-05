class UsersController < ApplicationController

  before_action :set_user
  respond_to :html, :json



  def show
    @stryke = Stryke.new
  end

  def edit
    unless current_user == @user
      redirect_to '/'
      flash[:alert] = "You don't have access to that page!"
    end
  end

  def update
    if current_user.update(user_params)

      if params[:user][:avatar].present?
        render :crop
      else
        if user_params.values.first == "A"
          render text: "Male"
        elsif user_params.values.first == "B"
          render text: "Female"
        elsif user_params.values.first == "C"
          render text: "Do not specify"
        else
          redirect_to user_path(current_user)
        end
      end

    else
      render :crop
    end
    # respond_with @user
  end

private

  def user_params
      params.require(:user).permit(:avatar, :crop_x, :crop_y, :crop_w, :crop_h,
      :spark_count, :location, :work, :school, :birthday, :sex, :interest,
      :about, :first_name, :last_name)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
