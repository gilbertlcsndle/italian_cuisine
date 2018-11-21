class Contact
  include ActiveModel::Model
  attr_accessor :name, :email, :subject, :message

  validates :name, presence: true
  validates :email, presence: true,
                    format: { with: /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i }
  validates :subject, presence: true
  validates :message, presence: true
end
