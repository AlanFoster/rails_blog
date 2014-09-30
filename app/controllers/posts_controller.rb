class PostsController < ApplicationController
  before_action :set_post, only: [:show]

  def index
    @posts = Post.paginate(page: params[:page], per_page: 3).order(created_at: :desc)
  end

  def overview
    @overview = PostsController.overview_of_posts
  end

  # TODO is there a way to get rid of this
  def self.overview_of_posts
    Post.all
      .group_by { |post| post.created_at.month }
      .map_keys { |ordinal_month| Date::MONTHNAMES[ordinal_month]  }
  end

  def show
    @new_comment = Comment.new post: @post
  end


  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :content)
    end
end

# Can we not do this?
class Hash
  def map_keys(&block)
    Hash[self.map { |k, v| [block.call(k), v] }]
  end
end
