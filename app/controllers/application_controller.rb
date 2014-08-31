class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_blog_overview

  # TODO is there a cleaner way of doing this?
  def set_blog_overview
    @overview = PostsController.overview_of_posts
  end
end
