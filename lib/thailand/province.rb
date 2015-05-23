require 'forwardable'
require 'thailand/country'
require 'thailand/region'
require 'thailand/querying'

module Thailand
  class Province < Region
    extend Querying
    extend SingleForwardable

    attr_reader :code

    def initialize(data = {}, parent = nil)
      @code = data['code']
      super
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
  end
end
