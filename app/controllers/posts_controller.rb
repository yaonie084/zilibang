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
    buffers = []
    @post.skills.each do |skill|
      buffer_skill << Tag.find(skill).name
    end
    @post.skills = buffers
    @post.state = "火热竞标中"
    if @post.valid_with_captcha?
      @post.save
      flash[:notice] = "创建成功"
      #respond_with(@user, :location => root_path())
      redirect_to posts_path()
    else
      render :action => :new
    end
  end

  def edit
    @post = Post.find(params[:id])
    @flag = "edit"
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
    @flag = "new"
  end

  def add_comment
    @comment = Comment.new(params[:comment])
    @comment.user = current_user
    @comment.post_id = params[:post_id]
    if @comment.valid_with_captcha?
      @comment.save
      flash[:notice] = "add comment success"
      redirect_to post_path(@comment.post_id)
    else
      flash[:notice] = "输入错误"
      redirect_to post_path(@comment.post_id)
    end
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
          current_user.delay.over_yes(comment.user,@post)
        else
          Message.create(:sender => User.find(1),:receiver => comment.user,:content =>"任务结束，竞标失败")
          current_user.delay.over_no(comment.user,@post)
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
          current_user.delay.finish(comment.user,@post)
        end
      end
    end
    flash[:notice] = "bussiness success"
    redirect_to post_path(@post)
  end


end
