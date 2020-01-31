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

      expect(Id.find_by(value: 'abc')).to eq(nil)
      expect(response.status).to eq(422)
    end
  end
end
