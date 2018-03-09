require 'rails_helper'

feature 'User makes a reservation', js: true do
  background(:each) do
    ActionMailer::Base.deliveries.clear
    visit root_path
  end

  subject { page }

  scenario 'with invalid input' do
    within '.mu-reservation-form' do
      fill_in 'reservation[name]', with: ' '
      fill_in 'reservation[email]', with: 'foobar@example.com'
      fill_in 'reservation[phone]', with: 'foobar'
      select 50, from: 'reservation[number_of_guests]'
      fill_in 'reservation[date_time]', with: DateTime.current.strftime("%m%d%Y\t%I%M%P")

      click_button 'Reservation'

      is_expected.to have_content 'error'
    end

    expect(ActionMailer::Base.deliveries.size).to eq(0)
  end

  scenario 'with valid input' do
    within '.mu-reservation-form' do
      reservation = attributes_for(:reservation)

      fill_in 'reservation[name]', with: reservation[:name]
      fill_in 'reservation[email]', with: reservation[:email]
      fill_in 'reservation[phone]', with: reservation[:phone]
      select reservation[:number_of_guests], from: 'reservation[number_of_guests]'
      fill_in 'reservation[date_time]', with: DateTime.current.strftime("%m%d%Y\t%I%M%P")
      fill_in 'reservation[message]', with: reservation[:message]

      click_button 'Reservation'

      is_expected.to have_content 'sent'
    end

    expect(ActionMailer::Base.deliveries.size).to eq(1)
  end
end
