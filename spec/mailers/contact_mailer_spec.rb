require 'rails_helper'

describe ContactMailer do
  let(:contact) { build(:contact) }
  let(:mail) { ContactMailer.new_message(contact) }

  it 'renders the headers' do
    expect(mail.subject).to eq(contact.subject)
    expect(mail.to).to eq(['gilbertlcsndle@gmail.com'])
    expect(mail.from).to eq(['noreply@osteriax.com'])
  end

  it 'renders the body' do
    expect(mail.body.encoded).to match(contact.name)
    expect(mail.body.encoded).to match(contact.email)
    expect(mail.body.encoded).to match(contact.message)
  end
end
