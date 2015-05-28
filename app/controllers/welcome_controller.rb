class WelcomeController < ApplicationController

  def index
    @strykes_hot_recent = []
    @strykes_hot = Stryke.order(created_at: :asc).order(spark_count: :asc).distinct
    @strykes_hot.each do |stryke|
      if Time.now.utc.to_i - stryke.created_at.to_i < 100000
        @strykes_hot_recent << stryke
      end
    end

    @strykes_new_recent = []
    @strykes_new = Stryke.order(created_at: :desc).distinct.all
    @strykes_new.each do |stryke|
      if Time.now.utc.to_i - stryke.created_at.to_i < 100000
        @strykes_new_recent << stryke
      end
    end
  end

end
