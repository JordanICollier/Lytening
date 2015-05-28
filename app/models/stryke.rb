class Stryke < ActiveRecord::Base

  belongs_to :user
  has_many :comments

  accepts_nested_attributes_for :comments

  # Old hotness algorithm
  # def hotness(stryke)
  #   s = stryke.created_at
  #   s = s + 2*stryke.spark_count
  #   baseScore = log(max(s,1))
  #
  #   timeDiff = (Date.now - stryke.created_at).toWeeks
  #
  #   if (timeDiff > 1)
  #     x = timeDiff - 1
  #     baseScore = baseScore * exp(-8*x*x)
  #   end
  #
  #   baseScore
  # end

end
