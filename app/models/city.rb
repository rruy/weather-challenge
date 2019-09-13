# frozen_string_literal: true

class City < ApplicationRecord
  validates :name, :uf, presence: true
end
