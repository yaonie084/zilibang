class HomeController < ApplicationController
  def index
  end

  def pay
    @post = Post.find(params[:id])
    @post.paid = true
    @post.save
    redirect_to @post
    
  end

end
