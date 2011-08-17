# coding: utf-8
class Profile < ActiveRecord::Base
  belongs_to :user
  validates :name, :presence => true
  validates :school, :presence => true
  validates :graduation, :presence => true
  validates :plan, :presence => true
  validates :tel, :presence => true
  validates_length_of :name, :in => 2..8, :message => "at least 2 word"
  validates_format_of :tel, :with => /(13[0-9]|15[0|3|6|7|8|9]|18[8|9])\d{8}/,
    :message => "请填写真实电话号码，方便任务双方联系"

  has_attached_file :avatar,
    :url  => "/system/profiles/:id/:style_:basename.:extension",
    :path => ":rails_root/public/system/profiles/:id/:style_:basename.:extension",
    :styles => { :normal => '220x160#', :thumb => '80x80#',
  },
    :default_style => :normal
  #has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }

  validates_attachment_size :avatar, :less_than => 2.megabytes


  #validates_attachment_presence :avatar

  def url(*args)
    avatar.url(*args)
  end
  alias :public_filename :url

  def url_normal
    url(:normal)
  end

  def url_thumb
    url(:thumb)
  end
end
