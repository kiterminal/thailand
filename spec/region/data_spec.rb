require 'spec_helper'

describe 'Check default data' do
  before do
    Thailand.reset_data_paths
    Thailand.reset_i18n_backend
  end

  after do
    reset_test_data_path
    reset_test_i18n_backend
  end

  context 'Thailand' do
    it 'has 77 provinces' do
      expect(Thailand::Province.all.size).to eql(77)
    end
  end

  context 'Bangkok' do
    let(:province)  { Thailand::Province.coded '10' }

    it 'has 50 districts' do
      expect(province.subregions.count).to eql(50)
    end

    it 'has 169 subdistricts' do
      subdistricts = 0
      province.subregions.each { |region| subdistricts += region.subregions.count }

      expect(subdistricts).to eql(169)
    end
  end
end
