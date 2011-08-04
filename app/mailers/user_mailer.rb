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
end
