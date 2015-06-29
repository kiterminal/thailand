require 'forwardable'
require 'thailand/country'
require 'thailand/region'
require 'thailand/querying'

module Thailand
  class Province < Region
    extend Querying
    extend SingleForwardable

    attr_reader :code, :region

    def initialize(data = {}, parent = nil)
      @code = data['code']
      @region = data['region']
      super
    end

    def region
      Thailand.i18n_backend.translate(path('region'))
    end

    def subregion_class
      District
    end

    def self.all
      Country.instance.subregions
    end

    def self.query_collection
      all
    end

    alias_method :amphoe, :subregions
    alias_method :amphoe?, :subregions?
    alias_method :khet, :subregions
    alias_method :khet?, :subregions?
  end
end
