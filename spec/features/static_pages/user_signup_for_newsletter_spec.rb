require 'rails_helper'

feature 'User signup for newsletter', js: true do
  given(:gibbon) { Gibbon::Request.new }
  given(:invalid_email) { 'foo@bar.com' }
  given(:valid_email) { 'johndoe@gmail.com' }

  background(:each) do
    visit root_path
  end

  scenario 'with invalid email' do
    fill_in 'subscribers[email]', with: invalid_email
    click_button 'Submit'
    expect(page).to have_content('There was an error registering you')
  end

  scenario 'with valid email' do
    fill_in 'subscribers[email]', with: valid_email
    click_button 'Submit'
    expect(page).to have_content('You have successfully subscribed')

    expect(email_subscribed?(gibbon, valid_email)).to be_truthy
    unsubscribe_email(gibbon, valid_email)
  end
end
