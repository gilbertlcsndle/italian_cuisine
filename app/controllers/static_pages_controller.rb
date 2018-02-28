class StaticPagesController < ApplicationController
  def home
    @contact = Contact.new
  end
end
