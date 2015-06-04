class Spark < ActiveRecord::Base
  belongs_to :user
  belongs_to :sparkable, polymorphic: true
  after_create :increment_spark_count
  after_destroy :decrement_spark_count

  private

  def increment_spark_count
    user.spark_count += 1
    user.save!
    sparkable.spark_count += 1
    sparkable.save!
  end

  def decrement_spark_count
    user.spark_count += 1
    user.save!
    sparkable.spark_count -= 1
    sparkable.save!
  end

end
