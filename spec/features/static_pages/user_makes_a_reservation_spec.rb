require 'rails_helper'

feature 'User makes a reservation' do
  scenario 'with invalid input' do
    ActionMailer::Base.deliveries.clear

    reservation = create(:reservation)

    visit root_path

    within '.mu-reservation-form' do
      fill_in 'Name', ' '
      fill_in 'Email', 'foobar@example..com'
      fill_in 'Phone', 'foobar'
      fill_in 'Guests', '60'
      fill_in 'Date', reservation.date_time
      fill_in 'Message', ' '

      click_button 'Reservation'

      expect(page).to have_content 'error'
    end

    expect(ActionMailer::Base.deliveries.size).to eq(0)
  end
end
