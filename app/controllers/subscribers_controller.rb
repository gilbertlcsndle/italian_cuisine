class SubscribersController < ApplicationController
  def create
    gibbon = Gibbon::Request.new
    begin
      gibbon.lists(ENV['MAILCHIMP_LIST_ID']).members.create(
        body: {
          email_address: params[:email],
          status: "subscribed" })
    rescue Gibbon::MailChimpError => e
      @error = e
    end
  end
end
