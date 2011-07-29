class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    @user.save
    flash[:notice] = "create_successful"
    #respond_with(@user, :location => root_path())
    redirect_to new_profile_path()
  end

  def register_check_instructions
    @user = User.find_by_persistence_token(params[:id])
    if @user != nil
      @user.role = "admin"
      @user.save
      flash[:notice] = "accept your account"
    end
    redirect_to root_url
  end
end