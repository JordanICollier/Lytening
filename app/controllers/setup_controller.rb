class SetupController < ApplicationController
  before_action :set_step
  before_action :see_if_done!
  # step names
  SETUP_STEPS = [
    'intro',
    #'avatar',
    'profile',
    # 'friends',
  ]

  # whitelist of endpoints that are ok to hit
  WHITELIST = [
    {controller: 'followings', action: 'create'},
    {controller: 'followings', action: 'destroy'},
    {controller: 'welcome', action: 'search_results'},
    {controller: 'devise/sessions', action: 'destroy'},
  ]

  def self.can_visit(params)
    WHITELIST.any? do |white_params|
      white_params.all? do |key, value|
        params[key] == value
      end
    end
  end

  def show
    send "show_#{SETUP_STEPS[@step]}"
  end

  def save
    send "save_#{SETUP_STEPS[@step]}"
  end

  private

  ########## INTRO ##########
  def show_intro
    render 'intro'
  end

  def save_intro
    next_step
  end

  # TODO: finish
  ########## AVATAR ##########
  def show_avatar
    render 'avatar'
  end

  def save_avatar
    # skip this step if we were told to
    if params[:skip]
      next_step
      return
    end
    # if form worked and we saved
    if params[:user] and
        params[:user][:avatar] and
        current_user.update(user_params)
      @user = current_user
      render 'users/crop', url: @url
      return
    end
    # re-render the page
    show_avatar
  end

  ########## PROFILE ##########
  def show_profile
    @user = current_user
    render 'profile'
  end

  def save_profile
    if current_user.update(user_params)
      next_step
    else
      show_profile
    end
  end

  ########## FRIENDS ##########
  def show_friends
    @user = current_user
    @friends = []
    @interests = @user.interest.split(",")
    @interests.each do |interest|
      @friends += User.where("interest LIKE :query", query: "%#{interest}%")
    end
    @friends.uniq
    @friends.delete(@user)
    render 'friends'
  end

  def save_friends
    next_step
  end

  ########## HELPERS ##########
  def user_params
    params.require(:user).permit(:avatar, :first_name, :last_name, :username,
    :birthday, :sex, :location, :interest, :school, :work, :about)
  end

  def see_if_done!
    redirect_to all_path if @step.nil?
  end

  def next_step
    # still steps left
    unless @step == SETUP_STEPS.size - 1
      # move to the next step
      current_user.increment!(:setup_step)
      redirect_to setup_path(current_user.setup_step)
    # last step
    else
      # go to the home page
      current_user.update(setup_step: nil)
      redirect_to all_path
    end
  end

  def set_step
    @step = current_user.setup_step
    @url = setup_path(@step)
  end

end
