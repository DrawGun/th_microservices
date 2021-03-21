require 'application_helper'

RSpec.describe App, type: :request do
  describe 'GET /api/v1/ads' do
    let(:user_id) { 1 }

    before do
      create_list(:ad, 3, user_id: user_id)
    end

    it 'returns a collection of ads' do
      get '/api/v1/ads'

      expect(last_response.status).to eq(200)
      expect(response_body['data'].size).to eq(3)
    end
  end

  describe 'POST /api/v1/ads' do
    let(:user_id) { 1 }

    context 'missing parameters' do
      it 'returns an error' do
        post '/api/v1/ads'

        expect(last_response.status).to eq(422)
      end
    end

    context 'invalid parameters' do
      let(:ad_params) do
        {
          title: 'Ad title',
          description: 'Ad description',
          city: '',
        }
      end

      it 'returns an error' do
        post '/api/v1/ads', ad: ad_params, user_id: user_id

        expect(last_response.status).to eq(422)
        expect(response_body['errors']).to include(
          {
            'detail' => "can't be blank",
            'source' => {
              'pointer' => '/data/attributes/city'
            }
          }
        )
      end
    end

    context 'valid parameters' do
      let(:ad_params) do
        {
          title: 'Ad title',
          description: 'Ad description',
          city: 'City'
        }
      end

      let(:last_ad) { Ad.last }

      it 'creates a new ad' do
        expect { post '/api/v1/ads', ad: ad_params, user_id: user_id }
          .to change { Ad.count }.from(0).to(1)

        expect(last_response.status).to eq(201)
      end

      it 'returns an ad' do
        post '/api/v1/ads', ad: ad_params, user_id: user_id

        expect(response_body['data']).to a_hash_including(
          'id' => last_ad.id.to_s,
          'type' => 'ad'
        )
      end
    end
  end
end
