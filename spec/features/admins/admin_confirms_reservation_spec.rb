require 'rails_helper'

feature 'Admin confirms reservation' do
  given(:reservation) { create(:reservation) }
  given(:admin) { create(:admin_user) }

  background(:each) do
    sign_in(admin)
    clear_emails
    visit admin_reservation_path(reservation)
    click_link 'Confirm'
  end

  scenario 'they see the status changed to confirmed' do
    expect(page).to have_content('Confirmed')
  end

  scenario 'sends confirmed email to client' do
    open_email(reservation.email)
    expect(current_email.subject).to match('confirmed')
  end
end
