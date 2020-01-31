require 'rails_helper'

RSpec.describe IdsController, type: :controller do

  def response_data
    JSON.parse(response.body)['data']
  end

  describe 'create' do
    it 'successfully store an ID' do
      post :create, params: { value: 'ABC' }

      expect(Id.first&.value).to eq('ABC')
      expect(response_data).to eq('OK')
    end

    it 'fails if format is invalid' do
      post :create, params: { value: 'abc' }

      expect(Id.exists?(value: 'abc')).to eq(false)
      expect(response.status).to eq(422)
    end

    it 'stores and returns new ID if provided ID is taken' do
      Id.create!(value: 'ABC')

      post :create, params: { value: 'ABC' }

      expect(Id.count).to eq(2) 
      expect(response_data).to eq(Id.last.value)
    end
  end
end
