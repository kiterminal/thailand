require 'yaml'
require 'pathname'

lib_path = File.expand_path('../../lib', __FILE__)
$LOAD_PATH.unshift(lib_path)

require 'thailand/province'
require 'thailand/district'
require 'thailand/i18n'
require 'thailand/version'

module Thailand
  class << self
    attr_accessor :data_paths, :i18n_backend, :root_path

    def clear_data_paths
      Country.instance.reset!
      @data_paths = []
    end

    def reset_data_paths
      clear_data_paths
      @data_paths << Pathname.new(@root_path + 'data')
    end

    def reset_i18n_backend
      base_locale_path =  @root_path + 'locale'
      @i18n_backend = Thailand::I18n::Simple.new(base_locale_path)
    end
  end

  @root_path = Pathname.new(__FILE__) + '../..'
  reset_data_paths
  reset_i18n_backend
end
