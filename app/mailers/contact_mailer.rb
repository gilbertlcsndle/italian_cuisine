class ContactMailer < ApplicationMailer
  default to: "Gilbert <gilbertlcsndle@gmail.com>"

  def new_message(contact)
    @contact = contact
    mail subject: contact.subject
  end
end
