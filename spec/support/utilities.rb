def email_subscribed?(gibbon, email)
  result = gibbon.lists(ENV['MAILCHIMP_LIST_ID']) \
                 .members(Digest::MD5.hexdigest(email)) \
                 .retrieve

  if result.body['status'] == 'subscribed'
    return true
  elsif result.body['status'] == 'unsubscribed'
    return false
  else
    return result
  end
end

def unsubscribe_email(gibbon, email)
  gibbon.lists(ENV['MAILCHIMP_LIST_ID']) \
        .members(Digest::MD5.hexdigest(email)) \
        .update(body: { status: "unsubscribed" })
end

def sign_in(admin)
  visit new_admin_user_session_path
  fill_in 'Email', with: admin.email
  fill_in 'Password', with: admin.password
  click_button 'Login'
end
