class Spark < ActiveRecord::Base

  belongs_to :user
  belongs_to :stryke
  belongs_to :comment

end
