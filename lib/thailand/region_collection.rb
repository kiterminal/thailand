require 'thailand/querying'

module Thailand
  class RegionCollection < Array
    include Querying

    private

    def query_collection
      self
    end
  end
end
