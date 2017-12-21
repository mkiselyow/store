class OrderNotifierMailer < ApplicationMailer
  default from: 'Мапапама <mapapama.com.ua@gmail.com>'
  default to: 'mapapama.com.ua@gmail.com'

  def recieved(order)
    @order = order

    mail to: 'mapapama.com.ua@gmail.com', subject: 'Получен заказ "Мапапама"'
  end
end
