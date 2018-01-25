class ApiMailer < ApplicationMailer
  def access_token_mail(user, access_token)
    @user = user
    @access_token = access_token

    mail(to: @user.email, subject: "Your Api access_token")
  end
end
