class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.paginate(page: params[:page], per_page: 5).order(created_at: :desc)
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

  # GET /posts/1
  # GET /posts/1.json
  def show
    @new_comment = Comment.new post: @post
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)

    if @post.save
      redirect_to @post, notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    if @post.update(post_params)
      redirect_to @post, notice: 'Post was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    redirect_to posts_url, notice: 'Post was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
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
