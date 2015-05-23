require 'active_support/core_ext/string'

module Thailand
  module Querying
    # Find a region by code
    # Returns a region with the supplied code, or nil if none is found

    attr_reader :case_fold

    def coded(code)
      return nil if code.nil?

      code = code.downcase # Codes are all ASCII
      query_collection.find { |region| region.send(:code).downcase == code }
    end

    # Find a region by name.
    # name - The String name to search for.
    # options - The Hash options used to modify the search (default:{}):
    #           :fuzzy - Whether to use fuzzy matching when finding a
    #                    matching name (optional, default: false)
    #           :case  - Whether or not the match is case-sensitive
    #                    (optional, default: false)
    # Returns a region with the supplied name, or nil if none if found.
    def named(name, options = {})
      case_fold = case_insensitive?(name, options[:case])
      # These only need to be built once
      name = transform_downcase name, case_fold
      # 'fuzzy' just means substring, optionally case-insensitive (the second argument looks for nil, not falseness)
      regexp = options[:fuzzy] ? create_regexp(name, options[:case]) : nil

      query_collection.find do |region|
        found_literal = name === transform_downcase(region.name, case_fold)
        found_literal || options[:fuzzy] && regexp === region.name
      end
    end

    private

    def case_insensitive?(name, options_case)
      !options_case && name.respond_to?(:each_codepoint)
    end

    def create_regexp(name, case_sensitive)
      Regexp.new(name, case_sensitive ? nil : true)
    end

    def transform_downcase(name, case_insensitive)
      case_insensitive && name ? name.mb_chars.downcase.normalize : name
    end
  end
end
