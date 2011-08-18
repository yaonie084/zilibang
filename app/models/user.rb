# coding: utf-8
class User < ActiveRecord::Base
  ROLES = %w[admin user guest]
  apply_simple_captcha
#  validates :email, :presence => true
#  validates :password, :presence => true
  acts_as_authentic do |c|
    c.login_field = :email
  end
  acts_as_taggable_on :skills
  attr_accessor :old_password
  attr_protected :superadmin
  #attr_accessible :profile
  validate :validate_old_password, :if => :required_old_password?

  has_one :profile, :dependent => :destroy
  accepts_nested_attributes_for :profile,
    :allow_destroy => true

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
    reset_perishable_token!
    UserMailer.welcome_email(self).deliver
  end

  def deliver_forgot_instructions!
    reset_perishable_token!
    UserMailer.forgot_email(self).deliver
  end

  def deliver_pay(user,post)
    UserMailer.pay(user,post).deliver
  end
  def deliver_pay_code(user,post)
    UserMailer.pay_code(user,post).deliver
  end
  def deliver_finish(user,post)
    UserMailer.finish(user,post).deliver
  end
  def deliver_over_no(user,post)
    UserMailer.over_no(user,post).deliver
  end
  def deliver_over_yes(user,post)
    UserMailer.over_yes(user,post).deliver
  end
  def role?(base_role)
    ROLES.index(base_role.to_s) <= ROLES.index(role)
  end

  def system_messages
    self.receivements.select {|message| message.sender.id == 1}
  end

  def add_score!(level, tag)
    tag_id = Tag.find_by_name(tag).id

    if have_not?(tag)
      self.skill_list << tag
      self.save
    end
    tagging = Tagging.where("taggable_id = #{self.id} AND tag_id = #{tag_id} AND taggable_type = \"User\"").first
    tagging.score += level.to_i*10
    tagging.save
  end

  def have_not?(tag)
    return false if self.skill_list.include?(tag)
    true
  end
  
end
