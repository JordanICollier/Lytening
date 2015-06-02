class WelcomeController < ApplicationController

  def index

    @strykes_hot_recent = []
    @strykes_hot = Stryke.order(created_at: :asc).order(spark_count: :asc).distinct
    @strykes_hot.each do |stryke|
      if DateTime.now.utc - 24.hours <= stryke.created_at
        @strykes_hot_recent << stryke
      end
    end

    @strykes_new_recent = []
    @strykes_new = Stryke.order(created_at: :desc).distinct.all
    @strykes_new.each do |stryke|
      if DateTime.now.utc - 24.hours <= stryke.created_at
        @strykes_new_recent << stryke
      end
    end

    @comment = Comment.new
  end

  def search_results
    @search = params[:search]
    @friends = User.where("email LIKE :query OR username LIKE :query OR concat(first_name, ' ', last_name) LIKE :query", query: "%#{@search}%")
  end

end
