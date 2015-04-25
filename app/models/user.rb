class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :avatar, AvatarUploader
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
  after_update :crop_avatar

  has_many :strykes
  has_many :comments

  def crop_avatar
    avatar.recreate_versions! if crop_x.present?
  end



end
