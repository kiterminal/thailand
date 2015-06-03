require 'spec_helper'

describe 'Province' do
  subject { Thailand::Province.coded '10' }

  context 'basic methods' do
    it 'has a inspect value' do
      expect(subject.inspect).to eql('<#Thailand::Province name="Bangkok">')
    end

    it 'has a path' do
      expect(subject.path).to eql('thailand.10')
    end

    it 'has a code' do
      expect(subject.code).to eql('10')
    end

    it 'has a name' do
      expect(subject.name).to eql('Bangkok')
    end

    it 'has a region' do
      expect(subject.region).to eql('Central Thailand')
    end

    it 'has a reasonable explicit string conversion' do
      expect(subject.to_s).to eql('Bangkok')
    end

    it 'has subregions' do
      expect(subject.subregions?).to be_truthy
    end

    it 'has the correct subregion path' do
      expect(subject.subregion_data_path).to eql('region/10.yml')
    end
  end

  context 'subregions (districts)' do
    let(:subregion) { subject.subregions.first }

    it 'has a path' do
      expect(subregion.path).to eql('thailand.10.1001')
    end

    it 'has a code' do
      expect(subregion.code).to eql('1001')
    end

    it 'has a name' do
      expect(subregion.name).to eql('Phra Nakhon')
    end

    it 'has a parent' do
      expect(subregion.parent).to eql(subject)
    end

    it 'has subregions' do
      expect(subregion.subregions?).to be_truthy
    end

    it 'has the correct subregion path' do
      expect(subregion.subregion_data_path).to eql('region/10/1001.yml')
    end
  end

  context 'subregions (subdistricts)' do
    let(:district) { subject.subregions.first }
    let(:subregion) { district.subregions.first }

    it 'has a path' do
      expect(subregion.path).to eql('thailand.10.1001.100101')
    end

    it 'has a code' do
      expect(subregion.code).to eql('100101')
    end

    it 'has a name' do
      expect(subregion.name).to eql('Phra Borom Maha Ratchawang')
    end

    it 'has a parent' do
      expect(subregion.parent).to eql(district)
    end

    it 'does not have a subregion' do
      expect(subregion.subregions?).to be_falsey
    end
  end

  context 'querying' do
    let(:thailand) { Thailand::Country.instance }

    it 'can find subregions by exact name' do
      bangkok = thailand.subregions.named('Bangkok')

      expect(bangkok.name).to eql('Bangkok')
    end

    it 'can find subregions by case-insensitive search by default' do
      bangkok = thailand.subregions.named('bAngkOk')

      expect(bangkok.instance_of?(Thailand::Province)).to be_truthy
      expect(bangkok.name).to eql('Bangkok')
    end

    it 'can find subregions optionally case-sensitively' do
      bangkok = thailand.subregions.named('bAngkOk', case: true)
      expect(bangkok).to be_nil

      bangkok = thailand.subregions.named('Bangkok', case: true)
      expect(bangkok.instance_of?(Thailand::Province)).to be_truthy
      expect(bangkok.name).to eql('Bangkok')
    end

    it 'can find subregions with fuzzy (substring) matching optionally' do
      bangkok = thailand.subregions.named('Ban', fuzzy: true)

      expect(bangkok.instance_of?(Thailand::Province)).to be_truthy
      expect(bangkok.name).to eql('Bangkok')
    end

    it 'can find subregions by name using a regex' do
      bangkok = thailand.subregions.named(/Bangkok/)

      expect(bangkok.name).to eql('Bangkok')
    end

    it 'can find subregions by name using a case-insensitive regex' do
      bangkok = thailand.subregions.named(/bangkok/i)

      expect(bangkok.name).to eql('Bangkok')
    end

    it 'handles querying for a nil code safely' do
      expect(thailand.subregions.coded(nil)).to be_nil
    end

    it 'handles querying for a nil name safely' do
      expect(thailand.subregions.named(nil)).to be_nil
    end

    context 'unicode character handling' do
      before do
        Thailand.i18n_backend.locale = 'th'
      end

      after do
        Thailand.i18n_backend.locale = 'en'
      end

      it 'can find a country using unicode characters' do
        bangkok = thailand.subregions.named('กรุงเทพมหานคร')

        expect(bangkok.instance_of?(Thailand::Province)).to be_truthy
        expect(bangkok.name).to eql('กรุงเทพมหานคร')
      end

      it 'can find a country using unicode characters' do
        bangkok = thailand.subregions.named('กรุงเทพ', fuzzy: true)

        expect(bangkok.instance_of?(Thailand::Province)).to be_truthy
        expect(bangkok.name).to eql('กรุงเทพมหานคร')
      end
    end
  end

  context 'comparison' do
    let(:samut_prakarn) { Thailand::Province.coded '11' }

    it 'does a comparison' do
      expect(subject <=> samut_prakarn).to eql(-1)
      expect(samut_prakarn <=> subject).to eql(1)
    end
  end
end
