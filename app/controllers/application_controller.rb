class ApplicationController < ActionController::Base
  protect_from_forgery
  respond_to :html, :xml, :json
  helper_method :current_user_session, :current_user
  include SimpleCaptcha::ControllerHelpers
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to error_power_url
  end

  def self.rescue_errors
    rescue_from Exception,                            :with => :render_error
    rescue_from RuntimeError,                         :with => :render_error
    rescue_from ActiveRecord::RecordNotFound,         :with => :render_error
    rescue_from ActionController::RoutingError,       :with => :render_error
    rescue_from ActionController::UnknownController,  :with => :render_error
    rescue_from ActionController::UnknownAction,      :with => :render_error
  end
  rescue_errors unless Rails.env.development?


  def render_error(exception = nil)
    render :template => "/500", :status => 500, :layout => false
  end
  

  def self.authorize_namespace(options = {})
    before_filter(:authorize_namespace, options.slice(:only, :except))
    write_inheritable_hash(:authorize_namespace, options)
  end

  def authorize_namespace
    options = self.class.read_inheritable_attribute(:authorize_namespace)
    authorize!(params[:action].to_sym, options[:namespace])
  end

  def self.menu_nav_highlight(name)
    class_eval do
      before_filter { |c| c.instance_variable_set(:@menu_nav, name) }
    end
  end

  def self.sec_nav_highlight(name)
    class_eval do
      before_filter { |c| c.instance_variable_set(:@sec_nav, name) }
    end
  end

  def self.main_nav_highlight(name)
    class_eval do
      before_filter { |c| c.instance_variable_set(:@main_nav, name) }
    end
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

  def self.sec_nav_highlight(name)
    class_eval do
      before_filter { |c| c.instance_variable_set(:@sec_nav, name) }
    end
  end
end

def self.main_nav_highlight(name)
  class_eval do
    before_filter { |c| c.instance_variable_set(:@main_nav, name) }
  end
end