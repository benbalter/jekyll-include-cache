# frozen_string_literal: true

# A minimal in-memory cache exposing the subset of Jekyll::Cache's API we use
module JekyllIncludeCache
  class Cache
    extend Forwardable

    def_delegators :@cache, :[]=, :key?, :delete, :clear

    def initialize(_name = nil)
      @cache = {}
    end

    def getset(key)
      if key?(key)
        @cache[key]
      else
        value = yield
        @cache[key] = value
        value
      end
    end

    def [](key)
      if key?(key)
        @cache[key]
      else
        raise
      end
    end
  end
end
