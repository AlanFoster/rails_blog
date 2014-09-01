class SessionsController < ApplicationController
  def new
  end

  def index
    render :new
  end

  def create
    user = User.authenticate(user_params['email'], user_params['password'])
    if user
      session[:id] = user.id
      redirect_to admin_posts_path
    else
      flash[:error] = 'Invalid username or password'
      render :new
    end
  end

  def destroy
    session[:id] = nil
    redirect_to root_path
  end

  private
    def user_params
      params.permit(:email, :password)
    end
end
