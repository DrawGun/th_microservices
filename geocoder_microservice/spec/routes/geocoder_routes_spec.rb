RSpec.describe GeocoderRoutes, type: :routes do
  describe 'POST /' do
    before { allow(City).to receive(:find_by).and_return(city) }
    let!(:city) { nil }

    context 'missing parameters' do
      it 'returns an error' do
        post '/v1'

        expect(last_response.status).to eq(422)
      end
    end

    context 'invalid parameters' do
      before { allow(City).to receive(:find_by).and_return(nil) }

      it 'returns an error' do
        post '/v1', city_name: 'Invalid title'

        expected_meta = {"meta"=>nil}

        expect(last_response.status).to eq(200)
        expect(response_body).to eq(expected_meta)
      end
    end

    context 'valid parameters' do
      let!(:city) { create(:city, city_name: 'Москва') }

      it 'returns created status' do
        post '/v1', city_name: city.city_name

        expected_meta = {"meta"=>[55.7540471, 37.620405]}

        expect(last_response.status).to eq(200)
        expect(response_body).to eq(expected_meta)
      end
    end
  end
end
