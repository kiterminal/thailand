require 'forwardable'
require 'thailand/country'
require 'thailand/region'
require 'thailand/querying'

module Thailand
  class District < Region
    extend Querying
    extend SingleForwardable

    attr_reader :code

    def initialize(data = {}, parent = nil)
      @code = data['code']
      super
    end

    def self.all
      Country.instance.subregions.map(&:subregions).flatten
    end

    def self.query_collection
      all
    end

    alias_method :tambon, :subregions
    alias_method :tambon?, :subregions?
    alias_method :khwaeng, :subregions
    alias_method :khwaeng?, :subregions?
  end
end
