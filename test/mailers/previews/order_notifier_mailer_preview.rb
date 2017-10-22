# Preview all emails at http://localhost:3000/rails/mailers/order_notifier_mailer
class OrderNotifierMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/order_notifier_mailer/recieved
  def recieved
    OrderNotifierMailer.recieved
  end

end
