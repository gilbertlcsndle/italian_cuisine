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

  context "#close" do
    before(:each) do
      reservation.save
      reservation.close
    end

    it "sets status to 'Closed'" do
      expect(reservation.status).to eq('Closed')
    end
  end

  it 'saves email in lower case' do
    mixed_case_email = 'Foo@ExAMPle.CoM'
    reservation.email = mixed_case_email
    reservation.save
    expect(reservation.reload.email).to eq mixed_case_email.downcase
  end

  context ".pending" do
    it "returns pending reservations" do
      pending_reservation = create(:reservation)

      expect(Reservation.pending).to include(pending_reservation)
    end
  end

  context ".confirmed" do
    it "returns confirmed reservations" do
      confirmed_reservation = create(:reservation)
      confirmed_reservation.confirm

      expect(Reservation.confirmed).to include(confirmed_reservation)
    end
  end

  context ".closed" do
    it "returns closed reservations" do
      closed_reservation = create(:reservation)
      closed_reservation.close

      expect(Reservation.closed).to include(closed_reservation)
    end
  end

  context ".today" do
    it "returns reservations for today" do
      reservation_today = create(:reservation)

      expect(Reservation.today).to include(reservation_today)
    end
  end

  context ".upcoming" do
    it "returns upcoming reservations" do
      upcoming_reservation = create(:reservation, date_time: 1.day.from_now)

      expect(Reservation.upcoming).to include(upcoming_reservation)
    end
  end
end
