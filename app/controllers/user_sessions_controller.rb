# coding: utf-8
class UserSessionsController < ApplicationController
  layout "authlogic"
  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      redirect_to root_path(), :notice => "登录成功哦～"
    else
      flash[:notice] = "登录失败"
      render :action => :new
    end
  end

  def destroy
    current_user_session.destroy
    redirect_to new_user_session_url
  end
end
