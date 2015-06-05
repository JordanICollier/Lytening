module SparkableController
  
  def toggle_spark!(locals = {})
    sparkable = locals[:sparkable]
    # try to find the spark
    spark = sparkable.sparks.find_by(user: current_user)
    # destroy it if it exists
    if spark
      spark.destroy
    # create it if it doesn't
    else
      sparkable.sparks.create(user: current_user)
    end
    sparkable.reload
    # render the new partial
    render partial: 'sparks/spark', locals: locals
  end

end
