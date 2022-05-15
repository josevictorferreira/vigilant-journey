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

  describe 'GET /index' do
    it 'renders a successful response' do
      Saving.create! valid_attributes
      get savings_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      saving = Saving.create! valid_attributes
      get saving_url(saving), as: :json
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Saving' do
        expect do
          post savings_url,
               params: { saving: valid_attributes }, headers: valid_headers, as: :json
        end.to change(Saving, :count).by(1)
      end

      it 'renders a JSON response with the new saving' do
        post savings_url,
             params: { saving: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Saving' do
        expect do
          post savings_url,
               params: { saving: invalid_attributes }, as: :json
        end.to change(Saving, :count).by(0)
      end

      it 'renders a JSON response with errors for the new saving' do
        post savings_url,
             params: { saving: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        {
          value: 300.0
        }
      end

      it 'updates the requested saving' do
        saving = Saving.create! valid_attributes
        patch saving_url(saving),
              params: { saving: new_attributes }, headers: valid_headers, as: :json
        saving.reload
        expect(saving.value).to eq(300.0)
      end

      it 'renders a JSON response with the saving' do
        saving = Saving.create! valid_attributes
        patch saving_url(saving),
              params: { saving: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid parameters' do
      it 'renders a JSON response with errors for the saving' do
        saving = Saving.create! valid_attributes
        patch saving_url(saving),
              params: { saving: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested saving' do
      saving = Saving.create! valid_attributes
      expect do
        delete saving_url(saving), headers: valid_headers, as: :json
      end.to change(Saving, :count).by(-1)
    end
  end
end
