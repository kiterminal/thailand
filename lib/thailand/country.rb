require 'singleton'
require 'thailand/region'

module Thailand
  class Country < Region
    include Singleton

    def name
      'Thailand'
    end

    def official_name
      'Kingdom of Thailand'
    end

    def subregion_data_path
      'region.yml'
    end

    def subregion_class
      Province
    end

    def path
      'thailand'
    end

    def inspect
      "<##{self.class}>"
    end
  end
end
