class BugsController < ApplicationController

  skip_before_action :authenticate_user!

  def new
    @bug = Bug.new
  end

  def create
    @bug = Bug.new(bug_params)
    if @bug.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def bug_params
    params.require(:bug).permit(:title, :description)
  end

end
