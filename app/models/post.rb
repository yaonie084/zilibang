class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  acts_as_taggable_on :skills
  attr_accessor :skill_listable
  apply_simple_captcha

  def skill_listable
    self.skill_list.map {|x| Tag.find_by_name(x)}
  end
end