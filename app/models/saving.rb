# frozen_string_literal: true

class Saving < ApplicationRecord
  validates :value, presence: true, numericality: { only_decimal: true }

  before_create :set_default_date!

  scope :by_year, ->(year) { where('extract(year from date) = ?', year) if year.present? }
  scope :by_month, ->(month) { where('extract(month from date) = ?', month) if month.present? }

  def self.current_month_total
    current_time = Time.current

    Saving
      .by_year(current_time.year)
      .by_month(current_time.month)
      .sum(:value)
      .to_f
  end

  private

  def set_default_date!
    return if date.present?

    self.date = Time.zone.now
  end
end
