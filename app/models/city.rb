# frozen_string_literal: true

# == Schema Information
#
# Table name: cities
#
#  id   :integer          not null, primary key
#  name :string
#  uf   :string
#


class City < ApplicationRecord
  validates :name, :uf, presence: true
end
