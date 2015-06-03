require 'singleton'
require 'thailand/region'

module Thailand
  class Country < Region
    include Singleton

    def name
      Thailand.i18n_backend.translate 'thailand.name'
    end

    def official_name
      Thailand.i18n_backend.translate 'thailand.official_name'
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
