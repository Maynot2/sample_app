module ApplicationHelper
  def full_title(page = "")
    base_title = "Ruby on Rails Tutorial Sample App"
    if page.empty?
      base_title
    else
      "#{page} | #{base_title}"
    end
  end
end
