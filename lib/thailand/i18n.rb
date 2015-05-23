require 'yaml'
require 'thailand/utils'

module Thailand
  module I18n
    # A simple object to handle I18n translation in simple situations.
    class Simple
      DEFAULT_LOCALE = 'en'

      attr_accessor :cache
      attr_reader :fallback_locale, :locale_paths

      def initialize(*initial_locale_paths)
        self.locale = DEFAULT_LOCALE
        @fallback_locale = DEFAULT_LOCALE
        @locale_paths = []
        initial_locale_paths.each do |path|
          append_locale_path(path)
        end
      end

      def append_locale_path(path)
        reset!
        @locale_paths << Pathname.new(path)
      end

      # Set a new locale
      def locale=(locale)
        Thread.current[:locale] = locale.to_s
      end

      def locale
        Thread.current[:locale]
      end

      # Retrieve a translation for a key in the following format: 'a.b.c'
      def translate(key)
        read(key.to_s)
      end

      alias_method :t, :translate

      # Clear the cache. Should be called after appending a new locale path
      # manually (in case lookups have already occurred.)
      #
      # When adding a locale path, it's best to use #append_locale_path, which
      # resets the cache automatically.
      def reset!
        @cache = nil
      end

      def inspect
        "<##{self.class} locale=#{locale}>"
      end

      def available_locales
        load_cache_if_needed
        @cache.keys.sort
      end

      private

      def read(key)
        load_cache_if_needed
        translated = read_from_hash(key, @cache[locale])
        translated ||= read_from_hash(key, @cache[@fallback_locale]) if locale != @fallback_locale
        translated
      end

      def read_from_hash(i18n_key, source_hash)
        i18n_key.split('.').inject(source_hash) do |hash, key|
          hash[key] unless hash.nil?
        end
      end

      # Load all files located in @locale_paths, merge them, and store the result in @cache
      def load_cache_if_needed
        return unless @cache.nil?
        hashes = load_hashes_for_paths(@locale_paths)
        @cache = Utils.deep_hash_merge(hashes)
      end

      def load_hashes_for_paths(paths)
        paths.collect do |path|
          unless File.exist?(path)
            fail "Path #{path} not found when loading locale files"
          end
          Dir[path + '**/*.yml'].map do |file_path|
            YAML.load_file(file_path)
          end
        end.flatten
      end
    end
  end
end
