class FollowingsController < ApplicationController

  def create
    @following = current_user.followings.build(:follower_id => params[:follower_id])
    if @following.save
      redirect_to :back
    else
      render :new
    end
  end

  def destroy
    @following = current_user.followings.find(params[:id])
    @following.destroy
    redirect_to :back
  end

end
