class Stryke < ActiveRecord::Base

  belongs_to :user
  has_many :comments
  has_many :sparks

  accepts_nested_attributes_for :comments

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
