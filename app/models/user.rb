class User < ActiveRecord::Base
  ROLES = %w[admin user guest]
  acts_as_authentic do |c|
    c.login_field = :email
  end
  acts_as_taggable_on :skills
  attr_accessor :old_password
  attr_protected :superadmin
  validate :validate_old_password, :if => :required_old_password?
  has_one :profile
  has_many :posts
  has_many :comments
  has_many :sendments, :class_name => "Message", :foreign_key => "sender_id"
  has_many :receivements, :class_name => "Message", :foreign_key => "receiver_id"
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

  def deliver_register_instructions!
    reset_persistence_token!
    UserMailer.welcome_email(self).deliver
  end

  def role?(base_role)
    ROLES.index(base_role.to_s) <= ROLES.index(role)
  end

  def system_messages
    self.receivements.select {|message| message.sender.id == 1}
  end
  
end
