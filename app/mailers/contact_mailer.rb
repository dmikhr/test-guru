class ContactMailer < ApplicationMailer
  def send_to_admin(contact_params)
    #byebug
    @name = contact_params[:name]
    @email = contact_params[:email]
    @message = contact_params[:message]

    mail to: 'dp@khramtsov.net'
  end
end
