class PostsController < ApplicationController
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
      @post.save
      redirect_to post_path(@post)
    end
  end

  def finish
    @post = Post.find(params[:id])
    if current_user == @post.user
      @post.finish = true
      @post.save
      flash[:notice] = "bussiness success"
      redirect_to post_path(@post)
    end
  end

end
