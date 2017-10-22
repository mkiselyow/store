class OrderNotifierMailer < ApplicationMailer
  default from: 'Мапапама <mapapama.com.ua@example.com>'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_notifier_mailer.recieved.subject
  #
  def recieved(order)
    @order = order

    mail to: 'm.kiselyow@gmail.com', subject: 'Получен заказ "Мапапама"'
  end
end
