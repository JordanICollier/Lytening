class Setup < ActiveRecord::Base

  validates :first_name, :last_name, :username, :interest, :about, :birthday, :gender, presence: true
  validate :username, uniqueness: true

  # Checks that first and last name are only A-Z and a-z (no spaces, numbers, newlines, etc...)
  validates_format_of :first_name, :last_name, :with => /\A[-a-z]+\Z/

end
