require 'spec_helper'

describe 'Country' do
  subject { Thailand::Country.instance }

  context 'basic methods' do
    it 'has a inspect value' do
      expect(subject.inspect).to eql('#<Thailand::Country name: "Thailand", official_name: "Kingdom of Thailand">')
    end

    it 'has a path' do
      expect(subject.path).to eql('thailand')
    end

    it 'has a name' do
      expect(subject.name).to eql('Thailand')
    end

    it 'has a official name' do
      expect(subject.official_name).to eql('Kingdom of Thailand')
    end

    it 'has subregions' do
      expect(subject.subregions?).to be_truthy
    end

    it 'has the correct subregion path' do
      expect(subject.subregion_data_path).to eql('region.yml')
    end
  end

  context 'when subregion data file is missing' do
    before do
      Thailand.clear_data_paths
    end

    after do
      reset_test_data_path
    end

    it 'does not have a region' do
      expect(subject.subregions?).to be_falsey
      expect(subject.subregions).to be_empty
    end
  end
end
