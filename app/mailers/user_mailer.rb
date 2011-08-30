# coding: utf-8
class UserMailer < ActionMailer::Base
  default :from => "yaonie084@gmail.com",
          :subject => "自强帮邮件通知"

  def welcome_email(user)
    @user = user
    @url = "http://localhost:3000"
    @url += register_check_instructions_path(@user.perishable_token)
    mail(:to => user.email,
         :subject => "自强帮注册信息确认")
  end

  def forgot_email(user)
    @user = user
    @url = "http://localhost:3000"
    @url += forgot_check_instructions_path(@user.perishable_token)
        mail(:to => user.email,
         :subject => "自强帮重置密码信息")
  end

  def over_yes(user,post)
    @user = user
    @post = post
    @url = "http://localhost:3000"
    @url += post_path(@post.id)
    mail( :to => user.email,
          :subject => "您在自强帮接受的\"#{@post.title}\"任务已经结束竞标。")
  end
  def over_no(user,post)
    @user = user
    @post = post
    @url = "http://localhost:3000"
    @url += post_path(@post.id)
    mail( :to => user.email,
          :subject => "自强帮邮件通知-2")
  end
  def finish(user,post)
    @user = user
    @post = post
    @url = "http://localhost:3000"
    @url += post_path(@post.id)
    mail( :to => user.email,
          :subject => "自强帮邮件通知-3" )
  end
  def pay(user,post)
    @user = user
    @post = post
    @url = "http://localhost:3000"
    @url += post_path(@post.id)
    mail( :to => user.email,
          :subject => "您在自强帮接受的\"#{@post.title}\"任务，企业已经付清款数。")

  end
  def pay_code(user ,post)
    @user = user
    @post = post
    @url = "http://localhost:3000"
    @url += post_path(@post.id)
    mail( :to => user.email,
          :subject => "您在自强帮发布的\"#{@post.title}\"任务已经付清款数。"  )
  end
  def buyer_sure(user,post)
    @user = user
    @post = post
    @url = "http://localhost:3000"
    @url += post_path(@post.id)
    mail( :to => user.email,
          :subject => "自强帮邮件通知-6"
    )
  end
  def wait_buyer_sure(user,post)
    @user = user
    @post = post
    @url = "http://localhost:3000"
    @url += post_path(@post.id)
    mail( :to => user.email,
          :subject => "自强帮邮件通知-7"
    )

  end
  def wait_employer_sure(user,post)
    @user = user
    @post = post
    @url = "http://localhost:3000"
    @url += post_path(@post.id)
    mail( :to => user.email,
      :subject => "您在自强帮中发布的\"#{@post.title}\"任务，已经有用户接受任务。"
    )
  end
  def buyer_cancel(user,post)
    @user = user
    @post = post
    @url = "http://localhost:3000"
    @url += post_path(@post.id)
    mail( :to => user.email,
          :subject => "自强帮邮件通知-9"
    )
  end
  def employer_sure(user,post)
    @user = user
    @post = post
    @url = "http://localhost:3000"
    @url += post_path(@post.id)
    mail( :to => user.email,
          :subject => "自强帮邮件通知-10"
    )
  end
  def employer_cancel(user,post)
    @user = user
    @post = post
    @url = "http://localhost:3000"
    @url += post_path(@post.id)
    mail( :to => user.email,
          :subject => "自强帮邮件通知-11"
    )
  end
  def employer_over(user,post)
    @user = user
    @post = post
    @url = "http://localhost:3000"
    @url += post_path(@post.id)
    mail( :to => user.email,
          :subject => "自强帮邮件通知-12"
    )
  end
  def verify_code(user,post)
    @user = user
    @post = post
    @url = "http://localhost:3000"
    @url += post_path(@post.id)
    mail( :to => user.email,
          :subject => "自强帮邮件通知-13"
    )
  end
  def report_buyer(user,post)
    @user = user
    @post = post
    @url = "http://localhost:3000"
    @url += post_path(@post.id)
    mail( :to => user.email,
          :subject => "自强帮邮件通知-14"
    )
  end
  def report_employer(user,post)
    @user = user
    @post = post
    @url = "http://localhost:3000"
    @url += post_path(@post.id)
    mail( :to => user.email,
          :subject => "自强帮邮件通知-15"
    )
  end
end
