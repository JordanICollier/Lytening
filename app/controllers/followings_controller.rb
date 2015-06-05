class FollowingsController < ApplicationController

  def create
    @following = current_user.followings.build(:follower_id => params[:following][:follower_id])
    if @following.save
      render json: @following.to_json
    else
      render :new
    end
  end

  def destroy
    @following = current_user.followings.find_by(follower_id: params[:id])
    @following.destroy
    render nothing: true
  end

end
