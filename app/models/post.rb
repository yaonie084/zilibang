# coding: utf-8
class Post < ActiveRecord::Base
  self.per_page = 40
  belongs_to :user
  has_many :comments
  acts_as_taggable_on :skills
  attr_accessor :skill_listable
  apply_simple_captcha
  validates :title, :presence => true
  validates :description, :presence => true
  validates :longtime, :presence => true
  validates :tel,:low_price, :high_price, :presence => true
  validates_length_of :title, :minimum => 2
  validates_length_of :description, :minimum => 5
  validates_numericality_of :longtime, :only_integer => true,
                                       :greater_than_or_equal_to => 1,
                                       :less_than_or_equal_to => 100
  validates_format_of :tel, :with => /(13[0-9]|15[0|3|6|7|8|9]|18[8|9])\d{8}/,
                            :message => "请填写真实电话号码，方便任务双方联系"
  validates_numericality_of :low_price, :only_integer => true,
                                       :greater_than_or_equal_to => 10

  def skill_listable
    self.skill_list.map {|x| Tag.find_by_name(x)}
  end
end