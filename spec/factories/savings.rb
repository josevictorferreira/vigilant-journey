# frozen_string_literal: true

FactoryBot.define do
  factory :saving do
    value { 9.99 }
    date { Time.current }
  end
end
