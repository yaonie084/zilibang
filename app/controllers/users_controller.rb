# coding: utf-8
class UsersController < ApplicationController
  def new
    @user = User.new
    @user.build_profile
  end

  def create
    @user = User.new(params[:user])
    @user.role = "guest"
    @user.save
    @user.delay.deliver_register_instructions!
    flash[:notice] = "create_successful"
    #respond_with(@user, :location => root_path())
    redirect_to root_path()
  end

  def update
    @user = User.find_by_persistence_token(params[:user][:persistence_token])
    params[:user][:role] = "user"
    @user.update_attributes(params[:user])
    flash[:notice] = "修改密码成功"
    redirect_to root_url
  end

  def register_check_instructions
    @user = User.find_using_perishable_token(params[:id])
    if @user != nil
      @user.role = "user"
      @user.save
      flash[:notice] = "accept your account"
    end
    redirect_to root_url
  end

  def forgot_password
    @user = User.new
  end

  def forgot_password_sender
    email = params[:user][:email]
    @user = User.find_by_email(email)
    @user.delay.deliver_forgot_instructions!
    flash[:notice] = "发送成功"
    redirect_to root_url

  end

  def forgot_check_instructions
    @user = User.find_using_perishable_token(params[:id])
    if @user == nil
      flash[:notice] = "please show your real token for us"
      redirect_to root_url
    end
  end
end