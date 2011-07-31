class Center::MessagesController < Center::BaseController
  def index
    @system_messages = @user.system_messages
    @sender_box = @user.sendments
    @receiver_box = @user.receivements
    
  end

  def new
    @message = @user.sendments.new
  end

  def create
    @message = Message.new(params[:message])
    @message.sender = @user
    @message.save
    redirect_to center_messages_url
  end
end