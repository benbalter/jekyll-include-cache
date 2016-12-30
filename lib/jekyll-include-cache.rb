require "jekyll"

module JekyllIncludeCache
  autoload :Tag, "jekyll-include-cache/tag"

  class << self
    attr_writer :cache

    def cache
      @cache ||= {}
    end

    def reset
      JekyllIncludeCache.cache = {}
    end
  end
end

Liquid::Template.register_tag("include_cached", JekyllIncludeCache::Tag)
Jekyll::Hooks.register :site, :pre_render do |_site|
  JekyllIncludeCache.reset
end
