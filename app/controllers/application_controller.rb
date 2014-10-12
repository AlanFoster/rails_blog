class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :load_common_view_state

  def load_common_view_state
    @overview = Post.overview
    @current_user = current_user
  end

  def logged_in?
    current_user.present?
  end

  def current_user
    user = User.where(id: user_id).first
    unless user.present?
      self.user_id = nil
    end
    user
  end

  def current_user=(user)
    self.user_id = user.id
  end

  private

  def user_id
    session[:id]
  end

  def user_id=(id)
    session[:id] = id
  end
end
