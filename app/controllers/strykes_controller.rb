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
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  def show
    @stryke = Stryke.where(:id => params[:id]).take
    render json: @stryke
  end

  def update
    @stryke = Stryke.find(params[:id])
    @stryke.update!(params.require(:stryke).permit(:spark_count))
    render nothing: true
  end

  private

  def stryke_params
    params.require(:stryke).permit(:body, :user_id, :image_url)
  end

end
