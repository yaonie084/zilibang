class UsersController < ApplicationController
  def new
    @user = User.new
    @user.build_profile
  end

  def create
    @user = User.new(params[:user])
    @user.save
    @user.delay.deliver_register_instructions!
    flash[:notice] = "create_successful"
    #respond_with(@user, :location => root_path())
    redirect_to root_path()
  end

  def register_check_instructions
    @user = User.find_using_perishable_token(params[:id])
    if @user != nil
      @user.role = "admin"
      @user.save
      flash[:notice] = "accept your account"
    end
    redirect_to root_url
  end
end