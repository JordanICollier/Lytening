module Sparkable

  def self.included(includer)
    includer.send :include, SparkCountable
    includer.has_many :sparks, as: :sparkable, dependent: :destroy
  end

end
