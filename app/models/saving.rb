# frozen_string_literal: true

class Saving < ApplicationRecord
  validates :value, presence: true, numericality: { only_decimal: true }

  before_create :set_default_date!

  private

  def set_default_date!
    return if date.present?

    self.date = Time.zone.now
  end
end
