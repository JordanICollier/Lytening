class WelcomeController < ApplicationController

  def index
    @strykes_hot = Stryke.order(created_at: :asc).order(spark_count: :asc).distinct
    @strykes_new = Stryke.order(created_at: :desc).distinct.all
  end

end
