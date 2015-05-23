module Thailand
  module Utils
    # Merge an array of hashes deeply
    # Returns a merged hash
    def self.deep_hash_merge(hashes)
      return hashes.first if hashes.size == 1

      hashes.inject do |acc, hash|
        acc.merge(hash) do |_key, old_value, new_value|
          if old_value.respond_to?(:merge) && new_value.respond_to?(:merge)
            deep_hash_merge([old_value, new_value])
          else
            new_value || old_value
          end
        end
      end
    end

    # Merge arrays of hashes using the specified keys
    # Returns a single merges array of hashes
    def self.merge_arrays_by_keys(arrays, keys)
      arrays.each_with_object([]) do |array, aggregate|
        array.each do |new_hash|
          # Find the matching element in the agregate array
          existing = aggregate.find do |hash|
            keys.any? { |key| hash[key] && hash[key] == new_hash[key] }
          end

          # Merge the new hash to an existing one, or append it if new
          existing ? existing.merge!(new_hash) : aggregate << new_hash
        end
      end
    end
  end
end
