# coding: utf-8
class HomeController < ApplicationController
  def index
    @posts = Post.limit(10).order("created_at DESC")
  end

  def pay_sure
    @post = Post.find(params[:id])
    @comments = []
    @price = 0
    @post.comments.each do |comment|
      if comment.employer_sure == true and comment.buyer_sure == true
        @comments << comment
        @price += comment.price
      end
    end
  end

  def pay
    @post = Post.find(params[:id])
    if current_user == @post.user
      @post.paid = true
      @post.state = "雇主已经预付押金，等待中标者输入提现密码。"
      @post.save
      @verify_codes = []
      @post.comments.each do |comment|
        comment.code = verification
        comment.save
        @verify_codes << comment.user.profile.name.to_s+':'+comment.code.to_s
        Message.create(:sender => User.find(1),:receiver => comment.user,:content => "企业已付款")
        current_user.delay.deliver_pay(comment.user,@post)
      end
      content = "<p>您发布的任务:#{@post.title} 已经付款，以下是各位工人的提款密码，请妥善保存，当确定工作完成后发放给工人，工人借此在自强帮网站上领取报酬</p>"
      @post.comments.each do |comment|
        if comment.code != nil
          content += "<p>#{comment.user.profile.name}:#{comment.code}</p>"
        end
      end
      Message.create(:sender => User.find(1),:receiver => @post.user,:content => content)
      current_user.delay.deliver_pay_code(@post.user,@post)
      flash[:notice] = "支付成功,请到您的用户中心查看您雇佣的工人的提现密码，并且我们已经把提现密码发送到您的邮箱中，请妥善保存！"
      redirect_to @post
    
    end
  end

  def mailer
    current_user.delay.deliver_register_instructions!
    flash[:notice] = "重新发送验证邮件成功，请再次进入邮箱查收。"
    redirect_to root_url
  end
end
