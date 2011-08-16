class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  apply_simple_captcha
end
