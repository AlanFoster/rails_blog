class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
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
          :content,
          :post_id
      )
  end
end
