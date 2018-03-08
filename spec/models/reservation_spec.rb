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
  # it { should validate_presence_of(:date_time) }

  it 'validates the format of email' do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com foo@bar..com]

    addresses.each do |invalid_address|
      reservation.email = invalid_address
      expect(reservation).not_to be_valid
    end
  end
end
