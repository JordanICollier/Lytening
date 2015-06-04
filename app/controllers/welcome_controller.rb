class WelcomeController < ApplicationController

  def index
    columns = Stryke.get_columns(current_user, 25)
    @strykes_hot = columns[:top]
    @strykes_new = columns[:new]

    @comment = Comment.new
  end

  def search_results
    @search = params[:search]
    @friends = User.where("email LIKE :query OR username LIKE :query OR concat(first_name, ' ', last_name) LIKE :query", query: "%#{@search}%")
  end

end
