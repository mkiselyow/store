class OrderNotifierMailer < ApplicationMailer
  default from: 'Мапапама <mapapama.com.ua@gmail.com>'
  default to: 'mapapama.com.ua@gmail.com'

  def recieved(order)
    @order = order

    mail to: 'mapapama.com.ua@gmail.com', subject: 'Получен заказ "Мапапама"'
  end

  def user_order_recieved(order)
    @order = order

    mail(to: order.email, subject: 'Вы сделали заказ на mapapama.com.ua')
  end

  def complete_order(order)
    @order = order

    mail(to: order.email, subject: 'Ваш заказ был выполнен успешно')
  end
end
