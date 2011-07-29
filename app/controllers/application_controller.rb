class ApplicationController < ActionController::Base
  protect_from_forgery
  respond_to :html, :xml, :json
  helper_method :current_user_session, :current_user

  rescue_from CanCan::AccessDenied do |exception|
    puts "\n\nERROR:your are not enough of power xx----------\n\n"
    redirect_to root_url, :alert => exception.message
  end

  private
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.user
  end

  def verification(len = 12, code = '')
    chars = ('0'..'9').to_a
    length = chars.size
    1.upto(len) do |i|
      srand()
      code << chars[rand(length-1)]
    end
    return code
  end
end
