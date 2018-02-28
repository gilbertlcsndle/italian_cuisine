class ContactsController < ApplicationController
  def create
    @contact = Contact.new(params[:contact])
    @contact.request = request

    if @contact.deliver
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
                                      :message,
                                      :nickname)
    end
end
