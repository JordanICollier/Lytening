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
  has_many :sparks

  has_many :followings
  has_many :followers, :through => :followings

  has_many :inverse_followings, :class_name => "Following", :foreign_key => "follower_id"
  has_many :inverse_followers, :through => :inverse_followings, :source => :user

  def crop_avatar
    avatar.recreate_versions! if crop_x.present?
  end

  accepts_nested_attributes_for :strykes

  def full_name
    first_name + " " + last_name
  end

  def active_stryke
    stryke = self.strykes.order(created_at: :desc).first
    if DateTime.now.utc - 24.hours <= stryke.created_at
      stryke
    end
  end

end
