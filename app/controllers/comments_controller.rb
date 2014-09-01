class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    if @comment.save
      redirect_to @comment.post
    end
  end

  private

  def comment_params
    params
      .require(:comment)
      .permit(
          :name,
          :website,
          :content
      )
  end
end
