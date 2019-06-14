class ContactMailer < ApplicationMailer
  default to: -> { 'dp@khramtsov.net' },
          from: 'TestGuru'

  def send_to_admin(contact_params)
    @name = contact_params[:name]
    @email = contact_params[:email]
    @message = contact_params[:message]

    mail subject: 'Message from TestGuru'
  end
end
