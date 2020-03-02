class LikesController < ApplicationController

  before_action :find_like, only: [:show, :destroy]

  def show
  end

  def index
    @exhibition = Exhibition.find(params[:exhibition_id])
    @like_id = 0
    @exhibition.likes.each do |like|
      if like.user_id == current_user.id
        @like_id = like.id
      end
    end
    render :layout => nil
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


