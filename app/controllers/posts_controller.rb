# coding: utf-8
class PostsController < ApplicationController
  load_and_authorize_resource
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @have_comment = nil
    @comments = @post.comments
    @comment = @post.comments.new
    #flash[:notice] = "xx"
  end

  def create
    @post = Post.new(params[:post])
    @post.user = current_user
    buffer_skill = []
    @post.skill_list.each do |skill|
      buffer_skill << Tag.find(skill).name
    end
    @post.skill_list = buffer_skill
    @post.state = "火热竞标中"
    @post.save
    flash[:notice] = "create_successful"
    #respond_with(@user, :location => root_path())
    redirect_to posts_path()
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.update_attributes(params[:post])
    flash[:notice] = "update_successful"
    redirect_to posts_path()
  end

  # DELETE /news/1
  # DELETE /news/1.xml
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    redirect_to posts_path()
  end

  def new
    redirect_to root_path if current_user == nil
    @post = current_user.posts.new
  end

  def add_comment
    @comment = Comment.new(params[:comment])
    @comment.user = current_user
    @comment.post_id = params[:post_id]
    @comment.save
    flash[:notice] = "add comment success"
    redirect_to post_path(@comment.post_id)
  end

  def over
    @post = Post.find(params[:id])
    if current_user == @post.user
      @post.over = true
      @post.state = "竞标结束，等待雇主付押金"
      @post.save
      @post.comments.each do |comment|
        if comment.buyer_sure == true and comment.employer_sure
          Message.create(:sender => User.find(1),:receiver => comment.user,:content =>"任务结束，竞标成功")
        else
          Message.create(:sender => User.find(1),:receiver => comment.user,:content =>"任务结束，竞标失败")
        end
      end
      redirect_to post_path(@post)
    end
  end

  def finish
    @post = Post.find(params[:id])
    if current_user == @post.user
      @post.state = "任务结束，请互相评分来提高信用等级"
      @post.finish = true
      @post.save
      @post.comments.each do |comment|
        if comment.buyer_sure == true and comment.employer_sure
          Message.create(:sender => User.find(1),:receiver => comment.user,:content =>"工作完成")
        end
      end
    end
    flash[:notice] = "bussiness success"
    redirect_to post_path(@post)
  end


end
