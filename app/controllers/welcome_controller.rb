class WelcomeController < ApplicationController

  def index
    @strykes = current_user.followers.map {|user| user.active_stryke}.compact
    my_stryke = current_user.active_stryke
    @strykes << my_stryke if my_stryke

    @strykes_hot = @strykes.sort_by(&:spark_count).first(25)
    @strykes_new = @strykes.sort_by(&:created_at).first(25)

    @comment = Comment.new
  end

  def search_results
    @search = params[:search]
    @friends = User.where("email LIKE :query OR username LIKE :query OR concat(first_name, ' ', last_name) LIKE :query", query: "%#{@search}%")
  end

end
