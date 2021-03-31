RSpec.describe Geocoder::FindCityService do
  subject { described_class }

  context 'existent city' do
    let(:city) { create(:city, title: 'Москва') }

    it 'can return coordinates data' do
      result = subject.call(city.title)

      expect(result.coordinates).to eq([city.lat, city.lon])
    end
  end

  context 'non-existent city' do
    it 'can`t return coordinates data' do
      result = subject.call('Non-existent city')

      expect(result.coordinates).to be_nil
    end
  end
end
