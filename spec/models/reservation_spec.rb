require 'rails_helper'

describe Reservation do
  let(:reservation) { build(:reservation) }

  it 'has a valid factory' do
    expect(reservation).to be_valid
  end

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:phone) }
  it { should validate_numericality_of(:phone).only_integer }
  it { should validate_presence_of(:number_of_guests) }
  it { should validate_presence_of(:date_time) }

  it 'validates the format of email' do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com foo@bar..com]

    addresses.each do |invalid_address|
      reservation.email = invalid_address
      expect(reservation).not_to be_valid
    end
  end

  it 'sends notification email to admin and client on create' do
    ActionMailer::Base.deliveries.clear
    reservation.save
    expect(ActionMailer::Base.deliveries.size).to eq(2)
  end

  it "sets status to 'Pending' on new record" do
    reservation.save
    expect(reservation.reload.status).to eq('Pending')
  end

  context '#confirm' do
    before(:each) do
      reservation.save
      ActionMailer::Base.deliveries.clear
      reservation.confirm
    end

    it "sets status to 'Confirmed'" do
      expect(reservation.status).to eq('Confirmed')
    end

    it 'sends confirmed email to client' do
      expect(ActionMailer::Base.deliveries.size).to eq(1)
    end
  end
end
