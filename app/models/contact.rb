class Contact < MailForm::Base
  attribute :name
  attribute :email
  attribute :subject
  attribute :message
  attribute :nickname, captcha: true

  validates :name, presence: true
  validates :email, presence: true,
                    format: { with: /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i }
  validates :subject, presence: true
  validates :message, presence: true

  def headers
    {
      subject: self.subject,
      to: 'gilbertlcsndle@gmail.com',
      from: "#{name} <#{email}>"
    }
  end
end
