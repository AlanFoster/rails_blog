module ApplicationHelper
  def style_for(path)
    'active' if request.path.starts_with?(path)
  end

  def javascript_include_tag(url, options={})
    x = super(url, options)
  end
end
