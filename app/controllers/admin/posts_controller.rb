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
    @post.skill_list = []
    @post.save
    buffer = []
    params[:post]["skill_list"] = params[:post]["skill_ids"][1..-1]
    params[:post]["skill_list"].each do |tag|
      buffer << tag
    end
    params[:post].delete("skill_list")
    params[:post].delete("skill_ids")
    @post.skill_list = buffer
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
