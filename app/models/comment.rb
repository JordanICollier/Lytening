class Comment < ActiveRecord::Base

  belongs_to :user
  belongs_to :stryke
  has_many :sparks

  validates :body, length: { maximum: 500 }
  validates :body, :body_html, presence: true

  auto_html_for :body do
    html_escape
    image
    youtube(:width => 275, :height => 175, :autoplay => false)
    soundcloud(:width => 275, :height => 175, :autoplay => false)
    dailymotion(:width => 275, :height => 175, :autoplay => false)
    google_video(:width => 275, :height => 175, :autoplay => false)
    vimeo(:width => 275, :height => 175, :autoplay => false)
    metacafe
    google_map
    twitter
    flickr
    # instagram currently buggy
    liveleak(:width => 275, :height => 175, :autoplay => false)
    ted
    worldstar(:width => 275, :height => 175, :autoplay => false)
    hashtag
    link :target => "_blank", :rel => "nofollow"
    simple_format
  end

end
