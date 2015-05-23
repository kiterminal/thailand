if ENV['TRAVIS'] || ENV['COVERAGE']
  require 'simplecov'

  if ENV['TRAVIS']
    require 'coveralls'
    SimpleCov.formatter = Coveralls::SimpleCov::Formatter
  end

  SimpleCov.start do
    add_filter '/data/'
    add_filter '/locale/'
    add_filter '/spec/'
    add_filter '/spec_data/'
  end
end
