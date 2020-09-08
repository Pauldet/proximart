class LikesController < ApplicationController

  before_action :find_like, only: [:show, :destroy]

  def show
    #there is nothing inthere DO WE REALY NEED IT ?
  end

  def index
    @exhibitions = current_user.likes.map do |like|
      like.exhibition
    end
    @visits = current_user.subscriptions.map do |subscription|
      subscription.visit
    end
  end

  def create
    @like = Like.new
    @like.exhibition_id = params[:exhibition_id]
    @like.user_id = current_user.id
    @like.save
  end

  def new
    @like = Like.new
  end

  def destroy
    @like.destroy
    render :layout => nil
  end

  private

  def find_like
    @like = Like.find(params[:id])
  end

  def like_params
    params.require(:like).permit(:date, :review_content, :rating, :interested)
  end

end


