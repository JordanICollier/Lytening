class Comment < ActiveRecord::Base

  belongs_to :user
  belongs_to :stryke

  auto_html_for :body do
    html_escape
    image
    youtube(:width => 400, :height => 250, :autoplay => false)
    soundcloud
    dailymotion
    google_video
    vimeo
    metacafe
    google_map
    twitter
    flickr
    instagram
    liveleak
    ted
    worldstar
    hashtag
    link :target => "_blank", :rel => "nofollow"
    simple_format
  end

end
