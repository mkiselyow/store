class OrderNotifierMailer < ApplicationMailer
  default from: 'Мапапама <mapapama.com.ua@example.com>'
  default to: 'mapapama1994@gmail.com'

  def recieved(order)
    @order = order

    mail to: 'mapapama1994@gmail.com', subject: 'Получен заказ "Мапапама"'
  end
end
