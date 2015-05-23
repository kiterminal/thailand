require 'spec_helper'

describe 'Thailand.i18n_backend' do
  it 'sets an instance of I18n::Simple as the default backend' do
    backend = Thailand.i18n_backend

    expect(backend.class).to eql(Thailand::I18n::Simple)
    expect(backend.locale).to eql('en')
    expect(backend.inspect).to eql('<#Thailand::I18n::Simple locale=en>')
  end
end

describe 'I18n' do
  subject { Thailand::I18n::Simple.new spec_locale_path }

  it 'knows which locales are available' do
    expect(subject.available_locales).to eql(%w(en th))
  end

  it 'loads and merges yaml files' do
    expect(subject.t('thailand.10.name')).to eql('Bangkok')
    expect(subject.t('thailand.10.1001.name')).to eql('Phra Nakhon')
    expect(subject.t('thailand.10.1001.100101.name')).to eql('Phra Borom Maha Ratchawang')
  end

  context 'when change default locale' do
    before do
      subject.locale = 'th'
    end

    after do
      subject.locale = Thailand::I18n::Simple::DEFAULT_LOCALE
      subject.reset!
    end

    it do
      expect(subject.locale).to eql('th')
      expect(subject.t('thailand.10.name')).to eql('กรุงเทพมหานคร')
    end
  end

  context 'when locale file is missing' do
    let(:i18) { Thailand::I18n::Simple.new('tmp') }

    it 'raises' do
      expect { i18.t('thailand.10.name') }.to raise_error(RuntimeError)
      expect { i18.t('thailand.10.name') }.to raise_error('Path tmp not found when loading locale files')
    end
  end
end
