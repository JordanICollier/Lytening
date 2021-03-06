class StrykesController < ApplicationController
  include SparkableController

  def spark
    stryke = Stryke.find(params[:stryke_id])
    toggle_spark!(
      sparkable: stryke,
      active_img: 'spark-icon-yellow.png',
      inactive_img: 'spark-icon-white.png',
    )
  end

  def index
    # is this a public feed
    user = params[:public_feed] == 'true' ? nil : current_user
    # create a new comment for the partials
    @comment = Comment.new
    # grab columns from the database
    columns = Stryke.get_columns(10, params[:offset].to_i, user)
    # render each columns html in place
    [:new, :top].each do |key|
      columns[key] = render_strykes key, columns[key]
    end
    render json: columns
  end

  def new
    @stryke = Stryke.new
  end

  def create
    @stryke = Stryke.new(stryke_params)
    @stryke.user_id = current_user.id
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

  def render_strykes(name, strykes)
    # render each stryke's html
    strykes.map do |stryke|
      render_to_string partial: stryke, locals: {
        top_class: "#{name}-status"
      }
    # combine and return
    end.join('')
  end

end
