class Stryke < ActiveRecord::Base

  belongs_to :user
  has_many :comments
  include Sparkable

  accepts_nested_attributes_for :comments

  validates :body, length: { maximum: 500 }
  validates :body, :body_html, presence: true

  auto_html_for :body do
    html_escape
    image
    youtube(:autoplay => false)
    soundcloud(:autoplay => false)
    dailymotion(:autoplay => false)
    google_video(:autoplay => false)
    vimeo(:autoplay => false)
    metacafe(:autoplay => false)
    google_map
    twitter
    flickr
    # instagram currently buggy
    liveleak(:autoplay => false)
    ted
    worldstar(:autoplay => false)
    hashtag
    link :target => "_blank", :rel => "nofollow"
    simple_format
  end

  def self.column_query(order, offset, limit, user_id = nil)
    # create the optional follower join query
    follower_join = <<FOLLOW
  INNER JOIN followings
  ON followings.user_id = ? AND followings.follower_id = users.id
FOLLOW
    # create the main query
    main_query = <<QUERY
SELECT * FROM (
  SELECT
    strykes.*,
    row_number() OVER newest_by_user as new_rank
  FROM users

#{user_id ? follower_join : ''}

  INNER JOIN strykes
  ON strykes.user_id = users.id

  WINDOW newest_by_user AS (
    PARTITION BY strykes.user_id
    ORDER BY strykes.created_at DESC
  )
) as strykes

WHERE new_rank = 1
ORDER BY #{order} DESC
OFFSET #{offset}
LIMIT #{limit}
QUERY
    # add the user_id if it was given
    result = [main_query]
    result << user_id if user_id
    return result
  end

  def self.get_columns(limit, offset = 0, user = nil)
    new_strykes = Stryke.find_by_sql(
      column_query('created_at', offset, limit, (user ? user.id : nil))
    )
    top_strykes = Stryke.find_by_sql(
      column_query('spark_count', offset, limit, (user ? user.id : nil))
    )
    done = new_strykes.size < limit or top_strykes.size < limit
    # return information about what we found
    {
      new: new_strykes,
      top: top_strykes,
      size: limit,
      done: done,
    }
  end

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
