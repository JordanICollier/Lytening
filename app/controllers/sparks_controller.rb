class SparksController < ApplicationController

  def new
    @spark = Spark.new
  end

  def create
    @spark = Spark.new(spark_params)

    @spark.user_id = current_user.id
    @spark.stryke_id = spark_params[:stryke_id]
    @spark.comment_id = spark_params[:comment_id]
    @spark.save

    if params[:stryke_id] == ""
      @comment = Comment.find(spark_params[:comment_id])
      @comment.spark_count += 1
      @comment.save

      @user = User.find(@comment.user_id)
      @user.spark_count += 1
      @user.save
    else
      @stryke = Stryke.find(spark_params[:stryke_id])
      @stryke.spark_count += 1
      @stryke.save

      @user = User.find(@stryke.user_id)
      @user.spark_count += 1
      @user.save
    end

    render json: @spark.to_json
  end

  def show
    @spark = Spark.where(:id => params[:id]).take
    render json: @stryke
  end

  def destroy
    @spark = Spark.find(params[:id])

    if params[:stryke_id] == ""
      @comment = Comment.find(@spark.comment_id)
      @comment.spark_count -= 1
      @comment.save

      @user = User.find(@comment.user_id)
      @user.spark_count -= 1
      @user.save
    else
      @stryke = Stryke.find(@spark.stryke_id)
      @stryke.spark_count -= 1
      @stryke.save

      @user = User.find(@stryke.user_id)
      @user.spark_count -= 1
      @user.save
    end

    @spark.destroy

    render nothing: true
  end

  private

  def spark_params
    params.require(:spark).permit(:user_id, :stryke_id, :comment_id, :self_id)
  end

end
