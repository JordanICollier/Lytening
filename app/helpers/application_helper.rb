module ApplicationHelper
  def avatar_url(user)
     gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
     # documentation on sizing
     # http://en.gravatar.com/site/implement/images/
     "https://gravatar.com/avatar/#{gravatar_id}.png?s=200"
 end

 def thumb_url(user)
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    # documentation on sizing
    # http://en.gravatar.com/site/implement/images/
    "https://gravatar.com/avatar/#{gravatar_id}.png?s=50"
  end
end
