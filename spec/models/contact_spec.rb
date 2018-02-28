require 'rails_helper'

describe Contact do
  let(:contact) { build(:contact) }

  it 'has a valid factory' do
    expect(contact).to be_valid
  end

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:message) }
  it { should validate_presence_of(:subject) }

  it 'validates the format of email' do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com foo@bar..com]

    addresses.each do |invalid_address|
      contact.email = invalid_address
      expect(contact).not_to be_valid
    end
  end
end
