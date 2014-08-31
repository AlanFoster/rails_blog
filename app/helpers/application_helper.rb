module ApplicationHelper
  def style_for(path)
    'active' if request.path.starts_with?(path)
  end
end
