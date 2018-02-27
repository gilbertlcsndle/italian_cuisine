class SubscribersController < ApplicationController
  def create
    gibbon = Gibbon::Request.new
    begin
      gibbon.lists(ENV['MAILCHIMP_LIST_ID']).members.create(
        body: {
          email_address: params[:subscribers][:email],
          status: "subscribed" })
    rescue Gibbon::MailChimpError => e
      @error = e
      if @error.title == 'Member Exists'
        gibbon.lists(ENV['MAILCHIMP_LIST_ID']) \
          .members(Digest::MD5.hexdigest(params[:subscribers][:email])) \
          .update(body: { status: "subscribed" })
        @error = nil
      end
    end
  end
end
