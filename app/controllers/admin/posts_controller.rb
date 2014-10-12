module Admin
  class PostsController < Admin::BaseController
    before_action :set_post, only: [:edit, :update]

    def index
      @posts = Post.paginate(page: params[:page], per_page: 5).order(created_at: :desc)
    end

    def edit
    end

    def new
      @post = Post.new
    end

    def create
      @post = Post.new(post_params)

      if @post.save
        redirect_to @post, notice: 'Post was successfully created.'
      else
        render :new
      end
    end

    def update
      if @post.update(post_params)
        redirect_to @post, notice: 'Post was successfully updated.'
      else
        render :edit
      end
    end

    private
      def set_post
        @post = Post.find(params[:id])
      end

      def post_params
        params.require(:post).permit(:title, :content)
      end
  end
end
