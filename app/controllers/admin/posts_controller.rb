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

  def pay
    @post = Post.find(params[:id])
    if current_user.role == 'admin'
      @post.paid = true
      @post.state = "雇主已经预付押金，等待中标者输入提现密码。"
      @post.save

      @verify_codes = []
      @post.comments.each do |comment|
        comment.code = verification
        comment.save
        @verify_codes << comment.user.profile.name.to_s+':'+comment.code.to_s
        current_user.delay.deliver_pay(comment.user,@post)
      end
      content = "<p>您发布的任务:#{@post.title} 已经付款，以下是各位工人的提款密码，请妥善保存，当确定工作完成后发放给工人，工人借此在自强帮网站上领取报酬</p>"
      @post.comments.each do |comment|
        if comment.code != nil
          content += "<p>#{comment.user.profile.name}:#{comment.code}</p>"
        end
      end
      current_user.delay.deliver_pay_code(@post.user,@post)
      flash[:notice] = "支付成功,请到您的用户中心查看您雇佣的工人的提现密码，并且我们已经把提现密码发送到您的邮箱中，请妥善保存！"
      redirect_to admin_posts_path()

    end
  end

end
