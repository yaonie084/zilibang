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
    @post.comments.each do |comment|
      comment.code = verification
      comment.save
    end
    flash[:notice] = "支付成功！"
    redirect_to @post
    
  end

end
