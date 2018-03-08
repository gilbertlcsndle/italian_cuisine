require 'rails_helper'

feature 'User submits the contact form', js: true do
  before(:each) do
    ActionMailer::Base.deliveries.clear
    visit root_path
  end

  subject { ActionMailer::Base.deliveries.size }

  context 'with invalid information' do
    context 'they will not receive email' do
      scenario 'when form is not completely filled in' do
        within '#ajax-contact' do
          fill_in 'Name', with: ' '
          fill_in 'Email', with: 'visitor@email.com'
          fill_in 'Subject', with: ' '
          fill_in 'Message', with: ' '
          click_button 'Send'
        end

        within '#form-messages' do
          expect(page).to have_content('error')
        end

        is_expected.to eq(0)
      end
    end
  end

  context 'with valid information' do
    scenario 'they will receive email' do
      within '#ajax-contact' do
        fill_in 'Name', with: 'Visitor'
        fill_in 'Email address', with: 'visitor@email.com'
        fill_in 'Subject', with: 'Contact subject'
        fill_in 'Message', with: 'Message'

        click_button 'Send'
      end

      within '#form-messages' do
        expect(page).to have_content('sent')
      end

      is_expected.to eq(1)
    end
  end
end
