require "jekyll"

module JekyllIncludeCache
  autoload :Tag, "jekyll-include-cache/tag"
end

Liquid::Template.register_tag("include_cached", JekyllIncludeCache::Tag)
