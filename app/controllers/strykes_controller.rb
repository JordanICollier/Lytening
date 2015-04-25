class StrykesController < ApplicationController

  def new
    @stryke = Stryke.new
  end

  def create
    @stryke = Stryke.new(stryke_params)
    @user = User.find(params[:user_id])
    @stryke.user_id = @user.id
    @stryke.spark_count = 0
    if @stryke.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def stryke_params
    params.require(:stryke).permit(:body, :user_id, :image_url)
  end

end
