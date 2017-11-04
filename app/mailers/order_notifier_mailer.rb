class OrderNotifierMailer < ApplicationMailer
  default from: 'Мапапама <mapapama.com.ua@example.com>'

  def recieved(order)
    @order = order

    mail to: 'm.kiselyow@gmail.com', subject: 'Получен заказ "Мапапама"'
  end
end
