class SendMessageMailer < ApplicationMailer
  default from: 'Hello'
  default to: 'mapapama1994@gmail.com'

  def new_send_message(send_message)
    @send_message = send_message

    mail subject: "Message from #{send_message.name}, #{send_message.email}"
  end
end
