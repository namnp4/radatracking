module ApplicationHelper
  def get_data(tag)
    return tag.selector.to_s.html_safe
  end
end
