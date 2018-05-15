class SubsController < ApplicationController
  before_action :require_logged_in, except: [:index]
  before_action :require_moderator, only: [:edit, :update]
  def index
    @subs = Sub.all
  end

  def new
    @sub = Sub.new
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.user_id = current_user.id
    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def edit
    @sub = Sub.find(params[:id])
  end

  def update
    @sub = current_user.subs.find(params[:id])
    if @sub.update_attributes(sub_params)
      redirect_to sub_url(@sub)
    else
      flash[:errors] = @sub.errors.full_messages
      render :edit
    end

  end

  def show
    @sub = Sub.find(params[:id])
    @posts = @sub.posts
    # cross post contains a relation that has a post id and a sub id 
    # @cross_posts = @sub.crossposts
  end

private
  def sub_params
    params.require(:sub).permit(:title, :description)
  end


  def require_moderator
    @sub = current_user.subs.find_by(id: params[:id])
    unless @sub
      flash[:errors] = ["Insufficient permissions"]
      redirect_to subs_url
    end
  end
end
