class SparksController < ApplicationController

  def create
    @spark = Spark.new(spark_params)
    @stryke = Stryke.find(params[:stryke_id])
    @comment = Comment.find(params[:comment_id])
    @user = User.find(params[:user_id])
    @spark.self_id = current_user.id
    @spark.stryke_id = @stryke.id
    @spark.comment_id = @comment.id
    @spark.user_id = @user.id
    render nothing: true
  end

  def show
    @spark = Spark.where(:id => params[:id]).take
    render json: @stryke
  end

  def destroy
    @spark = current_user.sparks.find(params[:id])
    @spark.destroy
    render nothing: true
  end

  private

  def spark_params
    params.require(:spark).permit(:user_id, :stryke_id, :comment_id, :self_id)
  end

end
