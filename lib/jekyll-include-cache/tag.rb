require "digest/md5"

module JekyllIncludeCache
  class Tag < Jekyll::Tags::IncludeTag
    def render(context)
      path   = path(context)
      params = parse_params(context) if @params
      return unless path

      key    = key(path, params)
      cached = cache(context)[key]

      if cached
        cached
      else
        cache(context)[key] = super
      end
    end

    private

    def path(context)
      site   = context.registers[:site]
      file   = render_variable(context) || @file
      locate_include_file(context, file, site.safe)
    end

    def key(path, params)
      Digest::MD5.hexdigest(path.to_s + params.to_s)
    end

    def cache(context)
      context.registers[:cached_includes] ||= {}
    end
  end
end
