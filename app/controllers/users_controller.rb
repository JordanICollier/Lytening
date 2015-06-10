class UsersController < ApplicationController

  before_action :set_user
  respond_to :html, :json



  def show
    @stryke = Stryke.new
    @user = User.find(params[:id])
    @sparked_items = []
    @expire_time = Time.now.utc - 24.hours
    @user.sparks.each do |spark|
      if spark.sparkable_type == "Stryke"
        @sparked_items += Stryke.where(id: spark.sparkable_id).where('created_at > :query', query: "%#{@expire_time}%")
      end
    end
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
      elsif params[:user][:crop_x]
        redirect_to user_path(current_user)
      else
        if user_params.values.first == "A"
          render text: "Male"
        elsif user_params.values.first == "B"
          render text: "Female"
        elsif user_params.values.first == "C"
          render text: "Do not specify"
        else
          render text: user_params.values[0]
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
