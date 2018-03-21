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

  it 'sends details to admin on create' do
    ActionMailer::Base.deliveries.clear
    reservation.save
    expect(ActionMailer::Base.deliveries.size).to eq(1)
  end

  it "sets status to 'Pending' on new record" do
    reservation.save
    expect(reservation.reload.status).to eq('Pending')
  end

  context '#confirm' do
    it "sets status to 'Confirmed'" do
      reservation.save
      reservation.confirm
      expect(reservation.status).to eq('Confirmed')
    end

    it "sets payment_status to 'Pending'" do
      reservation.save
      reservation.confirm
      expect(reservation.payment_status).to eq('Pending')
    end

    it "sends payment to client's email" do
      reservation.save
      ActionMailer::Base.deliveries.clear
      reservation.confirm
      expect(ActionMailer::Base.deliveries.size).to eq(1)
    end
  end

  context '#reject' do
    it "sets status to 'Rejected'" do
      reservation.save
      reservation.reject
      expect(reservation.status).to eq('Rejected')
    end
  end
end
