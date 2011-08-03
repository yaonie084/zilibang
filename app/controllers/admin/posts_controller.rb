# coding: utf-8
# To change this template, choose Tools | Templates
# and open the template in the editor.
class Admin::PostsController < Admin::BaseController
  #  load_and_authorize_resource
  main_nav_highlight :content
  sec_nav_highlight :posts
  def index
    @posts = Post.all
  end

 def show
    @post = Post.find(params[:id])
    @comments = @post.comments
    @comment = @post.comments.new
    flash[:notice] = "xx"
  end
  
  def new
    @post = current_user.posts.new
  end
  
  def create
    @post = Post.new(params[:post])
    @post.save
    flash[:notice] = "create_successful"
    #respond_with(@user, :location => root_path())
    redirect_to admin_posts_path()
  end
  
  def edit
    @post = Post.find(params[:id])
  end
  
  def update
    @post = Post.find(params[:id])
    @post.update_attributes(params[:post])
    flash[:notice] = "update_successful"
    redirect_to admin_posts_path()
  end
  
  # DELETE /news/1
  # DELETE /news/1.xml
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
  
    redirect_to admin_posts_path()
  end


end
