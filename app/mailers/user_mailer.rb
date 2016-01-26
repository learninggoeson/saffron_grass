class UserMailer < ActionMailer::Base
  default :from => 'Saffron Grass <saffrongrasspvtltd@gmail.com>'


  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.order_received.subject
  #
  def order_received(order)
    @order = order
    mail :to => order.email, :subject => 'Saffron Grass Order Confirmation'

  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.order_shipped.subject
  #
  def order_shipped(order)
    @order = order
    mail :to => order.email, :subject => 'Saffron Grass Order Shipped'
  end
end
