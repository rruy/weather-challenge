# frozen_string_literal: true

# == Schema Information
#
# Table name: cities
#
#  id   :integer          not null, primary key
#  name :string
#  uf   :string
#

require 'rails_helper'

RSpec.describe City, type: :model do
  
  describe "city validations" do
    
    context "with invalid data" do
      let!(:city) { build :city, name: nil }
      it "name is invalid" do
       expect(city).not_to be_valid
      end
    end

    context "with valid data" do
      let!(:city) { build :city }
      it "name is valid" do
        expect(city).to be_valid
      end
    end
  end

end
