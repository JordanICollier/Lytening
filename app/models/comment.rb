class Comment < ActiveRecord::Base

  belongs_to :user
  belongs_to :stryke
  include Sparkable

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

end
