class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.welcome.subject
  #
  def welcome(user)
    @user = user
    # @url = signin_url
    mail(to: @user.email, subject: 'Welcome to Nile.com', from: 'Nile.com')
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.order_received.subject
  #
  def order_received(order)
    @order = order
    @user = User.find(order.user_id)
    # @url = order_url
    mail(to: @user.email, subject: 'Thank you for your order from Nile.com', from: 'Nile.com')
  end
end
