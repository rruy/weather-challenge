# encoding: utf-8

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

require 'rails_helper'

RSpec.describe User, type: :model do

  describe "e-mail validations" do
    let(:user) { build :user, email: email }
    let(:email) { nil }

    context "with invalid data" do
      ["tes)te@gmail.com",  "tes{te@gmail.com", "tes[te@gmail.com", "tes(te@gmail.com", "teste teste@gmail.com",
        "teste;teste@gmail.com", "teste,teste@gmail.com", "abcd@efgh", "invalid:email@domain.com", "asd@asd.com;",
        ".asd@asd.com", "\"asd@asd.com", "'asd@asd.com", "as>d@asd.com", "as*d@asd.com", "test#@asd.com"]
      .each do |email|
        it "email #{email} is invalid" do
          user.email = email
          expect(user).not_to be_valid
        end
      end
    end

    context "with valid data" do
      ["t@gmail.com", "te@gmail.com", "teste.teste@gmail.com", "t.test@gmail.com", "abc.asd.def@gmail.com",
        "teste_teste@gmail.com", "teste+123@gmail.com", "teste-teste@gmail.com", "teste@abc.br"]
      .each do |email|
        it "email #{email} is valid" do
          user.email = email
          expect(user).to be_valid
        end
      end
    end

    context "when there is no email" do
      it "validates the email" do
        expect(user).not_to be_valid
        expect(user.errors[:email]).to include 'need fill'
      end
    end

  end

  describe "#user_name" do
    context "there is no first" do
      let(:user) { build :user, first_name: nil, email: 'user@totalpass.com.br' }

      it "returns the first part of email when there is no name" do
        expect(user.user_name).to eq 'user'
      end
    end
  end

end
