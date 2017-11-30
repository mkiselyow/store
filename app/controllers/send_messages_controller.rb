class SendMessagesController < ApplicationController
  def new
    @send_message = SendMessage.new
  end

  def create
    @send_message = SendMessage.new(message_params)

    if @send_message.valid?
      SendMessageMailer.new_send_message(@send_message).deliver
      redirect_to root_path, notice: 'Выше сообщение успешно отправлено, с вами свяжуться!'
    else
      flash[:alert] = 'Ошибка отправки сообщения!'
      render :new
    end
  end

  private

  def message_params
    params.require(:send_message).permit(:name, :email, :content)
  end
end
