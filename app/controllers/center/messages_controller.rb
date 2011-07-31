class Center::MessagesController < Center::BaseController
  def index
    @system_messages = @user.system_messages
    @sender_box = @user.sendments
    @receiver_box = @user.receivements
    
  end
end