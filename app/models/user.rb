# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  first_name             :string
#  last_name              :string
#  gender                 :string
#  phone                  :string
#  birthdate              :datetime
#

class User < ApplicationRecord

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, presence: true, length: { within: 8..254 }
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create

  validates :first_name, presence: true
  validates :last_name,  presence: true
  validates :phone,      presence: true, format: /\A\(\d{2}\)\s\d{8,9}\Z/
  before_validation :format_phone_number, :format_cpf_number, :sanitize_email, :validate_email_format

  def birthdate=(birthdate)
    birthdate.gsub!(/( |_)/, '') if birthdate.is_a?(String)
    super(birthdate)
  end

  protected

  def format_phone_number
    self.phone.try(:strip!)
    self.phone.try(:gsub!, '-', '')

    if self.phone.try(:match, /\A\d{2}\d{8,9}\Z/)
      self.phone = "(#{self.phone[0..1]}) #{self.phone[2..11]}"
    end
  end

  def format_cpf_number
    self.cpf.try(:strip!)

    if self.cpf.present? && !self.cpf.match(/\A\d{0,3}\.\d{3}\.\d{3}-\d{2}\Z/)
      cpf_number = self.cpf.gsub(/[ -]/, '').rjust(11, '0')
      self.cpf = "#{cpf_number[0..2]}.#{cpf_number[3..5]}.#{cpf_number[6..8]}-#{cpf_number[9..10]}"
    end
  end

  def validate_email_format
    regex = /\A\[a-zA-Z0-9@._]\Z/
    if self.email.present? && !self.email.match(regex)
      errors.add(:email, 'is not valid!')
    end
  end

  def sanitize_email
    self.email = I18n.transliterate(email) if self.email.present?
  end

end

