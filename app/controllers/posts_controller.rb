class PostsController < ApplicationController
  before_action :set_post, only: [:show]

  def index
    @posts = Post.paginate(page: params[:page], per_page: 3).order(created_at: :desc)
  end

  def overview
    @overview = Post.overview
  end

  def show
    @comment = Comment.new post: @post
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :content)
    end
end