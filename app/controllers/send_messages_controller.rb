class SendMessagesController < ApplicationController
  def new
    @send_message = SendMessage.new
  end

  def create
    @send_message = SendMessage.new(message_params)

    if @send_message.valid?
      SendMessageMailer.new_send_message(@send_message).deliver
      SendMessageMailer.answer_to_user(@send_message).deliver
      redirect_to root_path, notice: t('contact_form.send_success')
    else
      flash[:alert] =  t('contact_form.send_error')
      render :new
    end
  end

  private

  def message_params
    params.require(:send_message).permit(:name, :email, :content)
  end
end
