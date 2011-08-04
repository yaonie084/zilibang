# coding: utf-8
class HomeController < ApplicationController
  def index
  end

  def pay_sure
    @post = Post.find(params[:id])
    @comments = []
    @price = 0
    @post.comments.each do |comment|
      if comment.employer_sure == true and comment.buyer_sure == true
        @comments << comment
        @price += comment.price
      end
    end
  end

  def pay
    @post = Post.find(params[:id])
    @post.paid = true
    @post.save
    @verify_codes = []
    @post.comments.each do |comment|
      comment.code = verification
      comment.save
      @verify_codes << comment.user.profile.name.to_s+':'+comment.code.to_s
      Message.create(:sender => User.find(1),:receiver => comment.user,:content => "企业已付款")
    end
    Message.create(:sender => User.find(1),:receiver => @post.user,:content => "验证码:#{@verify_codes}")
    flash[:notice] = "支付成功！"
    redirect_to @post
    
  end

  def mailer
    current_user.delay.deliver_register_instructions!
    redirect_to root_url
  end

end
