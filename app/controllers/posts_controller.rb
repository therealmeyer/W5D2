class PostsController < ApplicationController
  before_action :require_logged_in
  before_action :require_permissions, only: [:edit, :update, :destroy]

  def new
    @post = Post.new
    @sub_id = params[:sub_id]
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.sub_id = params[:sub_id]
    if @post.save
      redirect_to sub_url(@post.sub_id)
    else
      flash[:errors] = @post.errors.full_messages
      @sub_id = params[:sub_id]
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to sub_url(@post.sub_id)
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find_by(id: params[:id])
    if @post.update_attributes(post_params)
      redirect_to sub_post_url(@post)
    else
      flash[:errors] = @post.errors.full_messages
      redirect_to :edit
    end
  end

private
  def post_params
    params.require(:post).permit(:title, :url, :content)
  end

  def require_permissions
    post = Post.find_by(id: params[:id])
    unless post && post.user_id == current_user.id
      flash[:errors] = ['Insufficient permissions']
      redirect_to sub_url(params[:id])
    end
  end

end
