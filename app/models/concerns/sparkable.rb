module Sparkable

  def self.included(includer)
    includer.include SparkCountable
    includer.has_many :sparks, as: :sparkable, dependent: :destroy
  end

end
