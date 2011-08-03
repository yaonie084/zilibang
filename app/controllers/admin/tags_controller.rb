class Admin::TagsController < Admin::BaseController
  main_nav_highlight :content
  sec_nav_highlight :tags
  def index
    @tags = Tag.all
  end

  def show
    
  end

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(params[:tag])
    @tag.save
    flash[:notice] = "create_successful"
    #respond_with(@user, :location => root_path())
    redirect_to admin_tags_path()
  end

  def destroy
    @tag = Tag.find(params[:id])
    @tag.destroy

    redirect_to admin_tags_path()
  end

end
