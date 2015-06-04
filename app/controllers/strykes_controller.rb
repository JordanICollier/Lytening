class StrykesController < ApplicationController

  def new
    @stryke = Stryke.new
  end

  def create
    @stryke = Stryke.new(stryke_params)
    @stryke.user_id = current_user.id
    @stryke.spark_count = 0
    @comment = Comment.new
    if @stryke.save
      render partial: @stryke, locals: {top_class: "new-status"}
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
