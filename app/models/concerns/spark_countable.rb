module SparkCountable

  def self.included(includer)
    includer.before_create :zero_spark_count
  end

  private

  def zero_spark_count
    self.spark_count = 0
  end

end
