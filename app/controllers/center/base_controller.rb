class Center::BaseController < ApplicationController
  authorize_namespace :namespace => Center
  before_filter :track_user

  def track_user
    @user = current_user
  end
end