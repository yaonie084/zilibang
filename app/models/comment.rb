class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  apply_simple_captcha
  validates_numericality_of :price, :only_integer => true,
    :greater_than_or_equal_to => 10
end
