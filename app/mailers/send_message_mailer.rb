class SendMessageMailer < ApplicationMailer
  default from: 'Hello'
  default to: 'mapapama.com.ua@gmail.com'

  def new_send_message(send_message)
    @send_message = send_message

    mail subject: "Пользователь #{send_message.email} оставил сообщение для вас"
  end

  def answer_to_user(send_message)
    @send_message = send_message

    mail(to: send_message.email, subject: 'Обратная связь с mapapama.com.ua')
  end
end
