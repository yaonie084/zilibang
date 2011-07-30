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
    @current_bids = []
    @current_work = []
    @passed_work = []
    @profile.user.comments.each do |c|
      @current_bids << c.post if c.post.paid == false
      @current_work << c.post if c.post.finish == false and c.buyer_sure == true and c.employer_sure == true and c.post.paid == true
      @passed_work  << c.post if c.post.finish == true
    end
    @bidding_job = []
    @working_job = []
    @passed_job = []
    @profile.user.posts.each do |p|
      @bidding_job << p if p.paid == false
      @working_job << p if p.paid == true and p.finish == false
      @passed_job << p if p.finish == true
    end
  end

end
