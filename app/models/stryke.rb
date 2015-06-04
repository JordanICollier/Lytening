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
    youtube(:width => 400, :height => 250, :autoplay => false)
    soundcloud(:width => 400, :height => 250, :autoplay => false)
    dailymotion(:width => 400, :height => 250, :autoplay => false)
    google_video(:width => 400, :height => 250, :autoplay => false)
    vimeo(:width => 400, :height => 250, :autoplay => false)
    metacafe
    google_map
    twitter
    flickr
    # instagram currently buggy
    liveleak(:width => 400, :height => 250, :autoplay => false)
    ted
    worldstar(:width => 400, :height => 250, :autoplay => false)
    hashtag
    link :target => "_blank", :rel => "nofollow"
    simple_format
  end

  def self.get_columns(user, limit, offset = 0)
    # find ever user's, including our, active stryke
    strykes = user.followers.map {|follower| follower.active_stryke}
    strykes << user.active_stryke
    # remove nil values
    strykes.compact!
    # calculate columns
    new_strykes = strykes
      .sort_by(&:created_at)
      .drop(offset)
      .first(limit)
    top_strykes = strykes
      .sort_by(&:spark_count)
      .reverse
      .drop(offset)
      .first(limit)
    # see if were done
    done = new_strykes.size < limit or top_strykes.size < limit
    # return information about what we found
    {
      new: new_strykes,
      top: top_strykes,
      size: limit,
      done: done,
    }

    # TODO: optimize using this code
    ## join query
    #join_query = <<EOF
#INNER JOIN users
#ON strykes.user_id = users.id OR users.id = 1531
#INNER JOIN followings
#ON followings.user_id = users.id
#EOF
    ## new strykes
    #new_strykes = Stryke
      #.joins(join_query)
      #.where('followings.follower_id = ?', user.id)
      #.where('created_at > ?', 24.hours.ago)
      #.order('created_at')
      #.offset(offset)
      #.limit(limit)
    #top_strykes = Stryke
      #.joins(join_query)
      #.where('followings.follower_id = ?', user.id)
      #.where('created_at > ?', 24.hours.ago)
      #.offset(offset)
      #.limit(limit)
    #{
      #new: new_strykes,
      #top: top_strykes,
    #}
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
