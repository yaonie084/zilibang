class UserMailer < ActionMailer::Base
  default :from => "yaonie084@gmail.com"

  def welcome_email(user)
    @user = user
    @url = "http://localhost:3000"
    @url += register_check_instructions_path(@user.perishable_token)
    mail(:to => user.email,
         :subject => "Welcome to Ziqiangbang Site")
  end
end
