class Profile < ActiveRecord::Base
  belongs_to :user
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
