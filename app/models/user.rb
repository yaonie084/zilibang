class User < ActiveRecord::Base
  acts_as_authentic do |c|
    c.login_field = :email
  end
  acts_as_taggable_on :skills, :interests
  attr_accessor :old_password
  attr_protected :superadmin
  validate :validate_old_password, :if => :required_old_password?
  has_one :profile
  has_many :posts
  def validate_old_password
    errors.add(:old_password) unless valid_password?(self.old_password)
  end

  def required_old_password!
    @old_password_required = true
    @password_changed = true
  end

  def required_old_password?
    @old_password_required
  end
end
