class HomeController < ApplicationController
  def index
  end

  def pay
    @post = Post.find(params[:id])
    @post.paid = true
    @post.save
    @post.comments.each do |comment|
      comment.code = verification
      comment.save
    end
    redirect_to @post
    
  end

end
