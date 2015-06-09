class Spark < ActiveRecord::Base
  belongs_to :user
  belongs_to :sparkable, polymorphic: true
  after_create :increment_spark_count
  after_destroy :decrement_spark_count

  private

  def increment_spark_count
    sparkable.user.increment!(:spark_count, 1)
    sparkable.increment!(:spark_count, 1)
  end

  def decrement_spark_count
    sparkable.user.decrement!(:spark_count, 1)
    sparkable.decrement!(:spark_count, 1)
  end

end
