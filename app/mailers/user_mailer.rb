# coding: utf-8
class UserMailer < ActionMailer::Base
  default :from => "yaonie084@gmail.com"

  def welcome_email(user)
    @user = user
    @url = "http://localhost:3000"
    @url += register_check_instructions_path(@user.perishable_token)
    mail(:to => user.email,
         :subject => "Welcome to Ziqiangbang Site")
  end

  def forgot_email(user)
    @user = user
    @url = "http://localhost:3000"
    @url += forgot_check_instructions_path(@user.perishable_token)
        mail(:to => user.email,
         :subject => "reset your password of Ziqiangbang Site")
  end

  def over_yes(user,post)
    @user = user
    @post = post
    @url = "http://localhost:3000"
    @url += post_path(@post.id)
    mail( :to => user.email,
          :subject => "自强帮任务确认")
  end
  def over_no(user,post)
    @user = user
    @post = post
    @url = "http://localhost:3000"
    @url += post_path(@post.id)
    mail( :to => user.email,
          :subject => "自强帮任务确认")
  end
  def finish(user,post)
    @user = user
    @post = post
    @url = "http://localhost:3000"
    @url += post_path(@post.id)
    mail( :to => user.email,
          :subject => "自强帮" )
  end
  def pay(user,post)
    @user = user
    @post = post
    @url = "http://localhost:3000"
    @url += post_path(@post.id)
    mail( :to => user.email,
          :subject => "自强帮")

  end
  def pay_code(user ,post)
    @user = user
    @post = post
    @url = "http://localhost:3000"
    @url += post_path(@post.id)
    mail( :to => user.email,
          :subject => "自强帮"  )
  end
  def buyer_sure(user,post)
    @user = user
    @post = post
    @url = "http://localhost:3000"
    @url += post_path(@post.id)
    mail( :to => user.email,
          :subject => "自强帮"
    )
  end
  def wait_buyer_sure(user,post)
    @user = user
    @post = post
    @url = "http://localhost:3000"
    @url += post_path(@post.id)
    mail( :to => user.email,
          :subject => "自强帮"
    )

  end
  def wait_employer_sure(user,post)
    @user = user
    @post = post
    @url = "http://localhost:3000"
    @url += post_path(@post.id)
    mail( :to => user.email,
          :subject => "自强帮"
    )
  end
  def buyer_cancel(user,post)
    @user = user
    @post = post
    @url = "http://localhost:3000"
    @url += post_path(@post.id)
    mail( :to => user.email,
          :subject => "自强帮"
    )
  end
  def employer_sure(user,post)
    @user = user
    @post = post
    @url = "http://localhost:3000"
    @url += post_path(@post.id)
    mail( :to => user.email,
          :subject => "自强帮"
    )
  end
  def employer_cancel(user,post)
    @user = user
    @post = post
    @url = "http://localhost:3000"
    @url += post_path(@post.id)
    mail( :to => user.email,
          :subject => "自强帮"
    )
  end
  def employer_over(user,post)
    @user = user
    @post = post
    @url = "http://localhost:3000"
    @url += post_path(@post.id)
    mail( :to => user.email,
          :subject => "自强帮"
    )
  end
  def verify_code(user,post)
    @user = user
    @post = post
    @url = "http://localhost:3000"
    @url += post_path(@post.id)
    mail( :to => user.email,
          :subject => "自强帮"
    )
  end
  def report_buyer(user,post)
    @user = user
    @post = post
    @url = "http://localhost:3000"
    @url += post_path(@post.id)
    mail( :to => user.email,
          :subject => "自强帮"
    )
  end
  def report_employer(user,post)
    @user = user
    @post = post
    @url = "http://localhost:3000"
    @url += post_path(@post.id)
    mail( :to => user.email,
          :subject => "自强帮"
    )
  end
end
