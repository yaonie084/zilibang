class Center::ProfilesController < ApplicationController
   before_filter :find_profile
  def show

  end

  def edit
  end

  def update
    @profile.update_attributes(params[:profile])
    flash[:notice] = "update_successful"
    respond_with(@profile, :location => center_profile_url)
  end

  def find_profile
    #@profile = Profile.find(params[:id])
    @profile = current_user.profile
  end

end
