# frozen_string_literal: true

require "jekyll"

module JekyllIncludeCache
  autoload :Tag,   "jekyll-include-cache/tag"
  autoload :Cache, "jekyll-include-cache/cache"

  class << self
    def cache
      @cache ||= if defined? Jekyll::Cache
                   # `self` is the module here, so `self.class.name` would be
                   # "Module" and share a namespace with any other plugin
                   # making the same mistake.
                   Jekyll::Cache.new(name)
                 else
                   JekyllIncludeCache::Cache.new
                 end
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
