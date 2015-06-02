class Spark < ActiveRecord::Base

  belongs_to :user
  belongs_to :spark
  belongs_to :comment

end
