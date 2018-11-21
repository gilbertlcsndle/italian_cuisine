require 'rails_helper'

feature 'User makes a reservation', js: true do
  background(:each) do
    ActionMailer::Base.deliveries.clear
    visit root_path
  end

  subject { page }

  scenario 'with invalid input' do
    within '#reservation-form' do
      fill_in 'reservation[name]', with: ' '
      fill_in 'reservation[email]', with: 'foobar@example.com'
      fill_in 'reservation[phone]', with: 'foobar'
      select 50, from: 'reservation[number_of_guests]'
      select DateTime.current.year, from: 'reservation[date_time(1i)]'
      select DateTime.current.strftime('%B'), from: 'reservation[date_time(2i)]'
      select DateTime.current.day - 1, from: 'reservation[date_time(3i)]'
      select DateTime.current.strftime('%H'), from: 'reservation[date_time(4i)]'
      select DateTime.current.strftime('%M'), from: 'reservation[date_time(5i)]'

      click_button 'Reservation'

      is_expected.to have_content 'error'
    end

    expect(ActionMailer::Base.deliveries.size).to eq(0)
  end

  scenario 'with valid input' do
    within '#reservation-form' do
      reservation = attributes_for(:reservation)

      fill_in 'reservation[name]', with: reservation[:name]
      fill_in 'reservation[email]', with: reservation[:email]
      fill_in 'reservation[phone]', with: reservation[:phone]
      select reservation[:number_of_guests], from: 'reservation[number_of_guests]'
      select reservation[:date_time].year, from: 'reservation[date_time(1i)]'
      select reservation[:date_time].strftime('%B'), from: 'reservation[date_time(2i)]'
      select reservation[:date_time].day, from: 'reservation[date_time(3i)]'
      select reservation[:date_time].strftime('%H'), from: 'reservation[date_time(4i)]'
      select reservation[:date_time].strftime('%M'), from: 'reservation[date_time(5i)]'
      fill_in 'reservation[message]', with: reservation[:message]

      click_button 'Reservation'

      is_expected.to have_content 'sent'
    end

    expect(ActionMailer::Base.deliveries.size).to eq(2)
  end
end
