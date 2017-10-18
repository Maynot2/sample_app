module UsersHelper
  def gravatar_for(user, size: 90)
    gravatar_hash = Digest::MD5::hexdigest user.email.downcase
    gravatar_url = "https://www.gravatar.com/avatar/#{gravatar_hash}?s=#{size}"
    image_tag gravatar_url, alt: "#{user.name} gravatar", class: "gravatar"
  end
end
