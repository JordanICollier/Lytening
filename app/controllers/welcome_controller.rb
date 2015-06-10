class WelcomeController < ApplicationController

  def public
    @navbar_title = 'Public Feed'
    @navbar_url = feed_path
    columns = Stryke.get_columns(25, 0)
    @strykes_hot = columns[:top]
    @strykes_new = columns[:new]

    @comment = Comment.new
    render 'welcome/index'
  end

  def index
    @navbar_title = 'Your Feed'
    @navbar_url = all_path
    columns = Stryke.get_columns(25, 0, current_user)
    @strykes_hot = columns[:top]
    @strykes_new = columns[:new]

    @comment = Comment.new
  end

  def search_results
    @search = params[:search].downcase
    @friends = User.where("LOWER(email) LIKE :query OR LOWER(username) LIKE :query OR LOWER(concat(first_name, ' ', last_name)) LIKE :query", query: "%#{@search}%")
  end

end
