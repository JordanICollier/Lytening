class Comment < ActiveRecord::Base

  belongs_to :user
  belongs_to :stryke
  has_many :sparks

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

end
