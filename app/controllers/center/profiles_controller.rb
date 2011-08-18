# coding: utf-8
class Center::ProfilesController < Center::BaseController
  before_filter :find_profile
  def show

  end

  def edit
  end

  def update
    @profile.update_attributes(params[:profile])
    flash[:notice] = "资料更新成功"
    redirect_to center_root_path
  end

  def find_profile
    #@profile = Profile.find(params[:id])
    @profile = current_user.profile
  end

  def change_password
    
  end

  def password_update
    if @user.valid_password?(params[:user][:old_password])
      params[:user][:role] = "user"
      
      if @user.update_attributes(params[:user])
        UserSession.create(:email => @user.email, :password => params[:user][:password])
        flash[:notice] = "密码修改成功"
        redirect_to center_root_path
      else
        flash[:notice] = "两次输的密码不一样"
        render :action => :change_password
      end
    
    else
    flash[:notice] = "当前密码错误"
    render :action => :change_password
    end
  end
end
