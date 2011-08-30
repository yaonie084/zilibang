class Admin::CommentsController < Admin::BaseController
  #  load_and_authorize_resource
  main_nav_highlight :content
  sec_nav_highlight :comments
  def index
    @comments = Comment.order("created_at DESC").paginate(:page => params[:page]||1, :per_page => 30)
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    @comment.update_attributes(params[:comment])
    flash[:notice] = "update successful"
    redirect_to admin_comments_path()
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash[:notice] = "destroy successful"
    redirect_to admin_comments_path()
  end


end