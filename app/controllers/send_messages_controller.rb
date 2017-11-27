class SendMessagesController < ApplicationController
  def new
    @send_message = SendMessage.new
  end

  def create
    @send_message = SendMessage.new(message_params)

    if @send_message.valid?
      SendMessageMailer.new_send_message(@send_message).deliver
      redirect_to root_path, notice: 'Your messages has been sent.'
    else
      flash[:alert] = 'An error occurred while delivering this message.'
      render :new
    end
  end

  private

  def message_params
    params.require(:send_message).permit(:name, :email, :content)
  end
end