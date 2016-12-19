require "jekyll"

module JekyllIncludeCache
  autoload :Tag, "jekyll-include-cache/tag"

  def self.cache
    @cache ||= {}
  end
end

Liquid::Template.register_tag("include_cached", JekyllIncludeCache::Tag)
