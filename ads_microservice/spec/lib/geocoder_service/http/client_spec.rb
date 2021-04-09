RSpec.describe GeocoderService::Http::Client, type: :client do
  subject { described_class.new(connection: connection) }

  let(:version) { 'v1' }
  let(:status) { 200 }
  let(:headers) { { 'Content-Type' => 'application/json' } }
  let(:body) { {} }
  let(:ad) { OpenStruct.new(city: city_name) }

  before do
    stubs.post("/geocode/#{version}") { [status, headers, body.to_json] }
  end

  describe '#geocode (correct city_name)' do
    let(:data) { [55.7540471, 37.620405] }
    let(:body) { { 'meta' => data } }
    let(:city_name) { 'Correct city name' }

    it 'returns correct data' do
      expect(subject.geocode(ad)).to eq(data)
    end
  end

  describe '#geocode (incorrect city_name)' do
    let(:data) { nil }
    let(:body) { { 'meta' => data } }
    let(:city_name) { 'Incorrect city name' }

    it 'returns correct data' do
      expect(subject.geocode(ad)).to eq(data)
    end
  end

  describe '#geocode (nil city_name)' do
    let(:status) { 403 }
    let(:city_name) { nil }

    it 'returns correct data' do
      expect(subject.geocode(ad)).to be_nil
    end
  end
end
