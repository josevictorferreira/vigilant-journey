# frozen_string_literal: true

class Saving < ApplicationRecord
  validates :value, presence: true, numericality: { only_decimal: true }
  validates :date, presence: true
end
