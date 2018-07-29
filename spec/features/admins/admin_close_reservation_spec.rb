require 'rails_helper'

feature 'Admin close reservation' do
  given(:admin) { create(:admin_user) }
  given(:reservation) { create(:reservation) }

  background(:each) do
    sign_in(admin)
    visit admin_reservation_path(reservation)
    click_link 'Close'
  end

  scenario "they see status changed to 'Closed'" do
    expect(page).to have_content('Closed')
  end
end
