class City < ApplicationRecord
  validates :name, :uf , presence: true

end
