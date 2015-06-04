class TutorialsController < ApplicationController

  def step_one

  end

  def step_two
    @user = current_user
    if params[:user] and @user.update(user_params)
      if params[:user][:avatar].present?
        render :crop
      else
        redirect_to step_three_path
      end
    end
  end

  def step_three
    @user = current_user
    if params[:user] and @user.update(user_params)
      redirect_to step_four_path
    end
  end

  def step_four
    @friends = []
    @interests = params[:interest].split(",")
    @interests.each do |interest|
      @friends << User.where("interest LIKE :query", query: "%#{interest}%")
    end
  end

  private

    def user_params
        params.require(:user).permit(:avatar, :first_name, :last_name, :username,
        :birthday, :sex, :location, :interest, :school, :work, :about)
    end

end
