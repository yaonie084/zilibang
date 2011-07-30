class ProfilesController < ApplicationController
  def new
    redirect_to root_path if current_user == nil
    @user = current_user
    @profile = Profile.new
    @profile.user = current_user
  end

  def create
    @profile = Profile.new(params[:profile])
    @profile.save
    @profile.user.delay.deliver_register_instructions!

    flash[:notice] = "create_success"
    redirect_to profile_path(@profile)
  end

  def show
    @profile = Profile.find(params[:id])
  end

end
