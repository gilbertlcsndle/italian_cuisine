class ContactsController < ApplicationController
  def create
    @contact = Contact.new(contact_params)

    if @contact.valid?
      ContactMailer.new_message(@contact).deliver_now
      flash.now[:success] = 'Your message has been sent.'
    else
      flash.now[:danger] = 'There was an error sending your message.'
    end
  end

  private
    def contact_params
      params.require(:contact).permit(:name,
                                      :email,
                                      :subject,
                                      :message)
    end
end
