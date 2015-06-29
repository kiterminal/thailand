require 'yaml'
require 'thailand/region_collection'
require 'thailand/utils'

module Thailand
  class Region
    attr_reader :code, :parent

    def initialize(data = {}, parent = nil)
      @code = data['code']
      @parent = parent
    end

    def name
      Thailand.i18n_backend.translate(path('name'))
    end

    def subregions
      @subregions ||= load_subregions
    end

    def subregions?
      !subregions.empty?
    end

    def subregion_data_path
      @parent.subregion_data_path.sub('.yml', "/#{subregion_directory}.yml")
    end

    def subregion_class
      Region
    end

    # Return a path string for this region. Useful for use with I18n
    # Returns a string in the format "thailand.$PARENT_CODE.$REGION_CODE", such as
    # "thailand.10.1001". The number of segments is the depth of the region plus one
    def path(suffix = nil)
      base = "#{@parent.path}.#{subregion_directory}"
      base << ".#{suffix}" if suffix
      base
    end

    def inspect
      "#<#{self.class} name: \"#{name}\">"
    end

    def to_s
      name
    end

    # Clears the subregion cache
    def reset!
      @subregions = nil
    end

    def <=>(other)
      name <=> other.name
    end

    private

    def subregion_directory
      @code.downcase
    end

    def load_subregions
      if Thailand.data_paths.any? { |path| (path + subregion_data_path).exist? }
        load_subregions_from_path(subregion_data_path, self)
      else
        []
      end
    end

    def load_subregions_from_path(path, parent = nil)
      regions = load_data_at_path(path).collect do |data|
        subregion_class.new(data, parent)
      end

      RegionCollection.new(regions)
    end

    def load_data_at_path(path)
      data_sets = Thailand.data_paths.map do |data_path|
        if File.exist?(data_path + path)
          YAML.load_file(data_path + path)
        else
          # :nocov:
          []
          # :nocov:
        end
      end

      flatten_data(data_sets)
    end

    def flatten_data(arrays)
      keys = %w(code)
      Utils.merge_arrays_by_keys(arrays, keys).reject do |hash|
        hash['_enabled'] == false
      end
    end
  end
end
