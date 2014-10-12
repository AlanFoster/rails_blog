class SessionsController < ApplicationController
  before_action :redirect_if_logged_in, except: [:destroy]

  def new
  end

  def index
    render :new
  end

  def create
    user = User.authenticate(user_params['email'], user_params['password'])
    if user
      self.current_user = user
      redirect_to admin_posts_path
    else
      flash[:error] = 'Invalid username or password'
      render :new
    end
  end

  def destroy
    reset_session
    redirect_to login_path
  end

  private
  def user_params
    params.permit(:email, :password)
  end

  def redirect_if_logged_in
    redirect_to admin_posts_path if logged_in?
  end
end
