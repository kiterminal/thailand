require 'support/coverage'
require 'thailand'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.raise_errors_for_deprecations!
end

def reset_test_data_path
  Thailand.clear_data_paths
  Thailand.data_paths << Pathname.new(spec_data_path)
end

def reset_test_i18n_backend
  Thailand.i18n_backend = Thailand::I18n::Simple.new spec_locale_path
end

def spec_data_path
  Thailand.root_path + 'spec_data/data'
end

def spec_locale_path
  Thailand.root_path + 'spec_data/locale'
end

reset_test_data_path
reset_test_i18n_backend
