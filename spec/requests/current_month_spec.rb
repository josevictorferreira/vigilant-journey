# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/savings', type: :request do
  let(:valid_attributes) do
    {
      value: 100.0,
      date: Time.now.iso8601
    }
  end

  let(:invalid_attributes) do
    {
      value: 'value',
      date: Time.now.iso8601
    }
  end

  let(:valid_headers) do
    {
      'Content-Type': 'application/json'
    }
  end

  describe 'GET /current_month' do
    it 'renders a successful response' do
      create(:saving, value: 100.0)
      create(:saving, value: 50.0)
      create(:saving, value: 50.0, date: Date.yesterday - 1.month)
      get '/savings/totals/month', headers: valid_headers, as: :json
      expect(JSON.parse(response.body, symbolize_names: true)[:total]).to eq(150.0)
    end
  end
end
