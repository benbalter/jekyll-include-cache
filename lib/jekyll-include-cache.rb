# frozen_string_literal: true

require "jekyll"

module JekyllIncludeCache
  autoload :Tag,   "jekyll-include-cache/tag"
  autoload :Cache, "jekyll-include-cache/cache"

  class << self
    # An in-memory cache of rendered includes.
    #
    # This deliberately doesn't use Jekyll::Cache: the cache is cleared on
    # every render, so persisting entries to disk (Marshal + SHA2 per write)
    # only costs time and never produces a hit on the next build.
    def cache
      @cache ||= JekyllIncludeCache::Cache.new
    end

    def reset
      JekyllIncludeCache.cache.clear
      # Keys are derived from object ids, which are only meaningful within a
      # single build, so don't let the memo grow across `jekyll serve` rebuilds.
      JekyllIncludeCache::Tag.digest_cache.clear
    end
  end
end

Liquid::Template.register_tag("include_cached", JekyllIncludeCache::Tag)
Jekyll::Hooks.register :site, :pre_render do |_site|
  JekyllIncludeCache.reset
end
