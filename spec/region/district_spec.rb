require 'spec_helper'

describe 'District' do
  subject { Thailand::District.coded '1001' }

  context 'basic methods' do
    it 'has a inspect value' do
      expect(subject.inspect).to eql('#<Thailand::District name: "Phra Nakhon">')
    end

    it 'has a path' do
      expect(subject.path).to eql('thailand.10.1001')
    end

    it 'has a code' do
      expect(subject.code).to eql('1001')
    end

    it 'has a name' do
      expect(subject.name).to eql('Phra Nakhon')
    end

    it 'has a reasonable explicit string conversion' do
      expect(subject.to_s).to eql('Phra Nakhon')
    end

    it 'has subregions' do
      expect(subject.subregions?).to be_truthy
    end

    it 'has the correct subregion path' do
      expect(subject.subregion_data_path).to eql('region/10/1001.yml')
    end
  end
end
