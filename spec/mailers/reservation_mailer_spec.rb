require 'rails_helper'

describe ReservationMailer do
  let(:reservation) { build(:reservation) }

  context "#new_reservation" do
    let(:mail) { ReservationMailer.new_reservation(reservation) }

    it 'renders the headers' do
      expect(mail.subject).to match('new reservation')
      expect(mail.to).to eq(['gilbertlcsndle@gmail.com'])
      expect(mail.from).to eq(['noreply@italiancuisine.com'])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match(reservation.name)
      expect(mail.body.encoded).to match(reservation.email)
      expect(mail.body.encoded).to match(reservation.phone)
      expect(mail.body.encoded).to match(reservation.number_of_guests.to_s)
      expect(mail.body.encoded).to match(reservation.date_time.strftime('%B %-d, %Y %I:%M %P'))
      expect(mail.body.encoded).to match(reservation.message)
    end
  end

  context "#client_notification" do
    let(:mail) { ReservationMailer.client_notification(reservation) }

    it 'renders the headers' do
      expect(mail.subject).to match('waiting')
      expect(mail.to).to eq([reservation.email])
      expect(mail.from).to eq(['noreply@italiancuisine.com'])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match('waiting')
      expect(mail.body.encoded).to match(reservation.name)
      expect(mail.body.encoded).to match(reservation.number_of_guests.to_s)
      expect(mail.body.encoded).to match(reservation.date_time.strftime('%B %-d, %Y %I:%M %P'))
    end
  end

  context "#confirmed_email" do
    let(:mail) { ReservationMailer.confirmed_email(reservation) }

    it 'renders the headers' do
      expect(mail.subject).to match('confirmed')
      expect(mail.to).to eq([reservation.email])
      expect(mail.from).to eq(['noreply@italiancuisine.com'])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match('confirmed')
      expect(mail.body.encoded).to match(reservation.name)
      expect(mail.body.encoded).to match(reservation.number_of_guests.to_s)
      expect(mail.body.encoded).to match(reservation.date_time.strftime('%B %-d, %Y %I:%M %P'))
    end
  end
end
