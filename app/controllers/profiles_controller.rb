class ProfilesController < ApplicationController

  def worker_show
    @profile_nav = "worker"
    @profile = Profile.find(params[:id])
    @user = @profile.user
    @current_bids = []
    @current_work = []
    @passed_work = []
    @profile.user.comments.each do |c|
      @current_bids << c.post if c.post.paid == false
      @current_work << c.post if c.post.finish == false and c.buyer_sure == true and c.employer_sure == true and c.post.paid == true
      @passed_work  << c.post if c.post.finish == true
    end

  end

  def bussiness_show
    @profile_nav = "bussiness"
    @profile = Profile.find(params[:id])
    @user = @profile.user
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
