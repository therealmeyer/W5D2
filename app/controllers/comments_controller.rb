class CommentsController < ApplicationController

  def new
    @comment = Comment.new
    @comment.post_id = params[:post_id]
    @comment.comment_id = params[:comment_id]
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @sub = @comment.sub
    if @comment.save
      redirect_to sub_post_url(@sub,@comment.post_id)
    else
      flash[:errors] = @comment.errors.full_messages
      render :new
    end
  end

  def show
    @comment = Comment.find(params[:id])
  end


  private
  def comment_params
    params.require(:comment).permit(:content, :post_id, :comment_id)
  end

end
