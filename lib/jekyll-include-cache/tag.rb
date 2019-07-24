# frozen_string_literal: true

require "digest/md5"

module JekyllIncludeCache
  class Tag < Jekyll::Tags::IncludeTag
    def self.digest_cache
      @digest_cache ||= {}
    end

    def render(context)
      path   = path(context)
      params = parse_params(context) if @params
      key = key(path, params)
      return unless path

      if JekyllIncludeCache.cache.key?(key)
        Jekyll.logger.debug "Include cache hit:", path
        JekyllIncludeCache.cache[key]
      else
        Jekyll.logger.debug "Include cache miss:", path
        JekyllIncludeCache.cache[key] = super
      end
    end

    private

    def path(context)
      site   = context.registers[:site]
      file   = render_variable(context) || @file
      locate_include_file(context, file, site.safe)
    end

    def key(path, params)
      path_hash   = path.hash
      params_hash = params.hash
      self.class.digest_cache[path_hash] ||= {}
      self.class.digest_cache[path_hash][params_hash] ||= digest(path_hash, params_hash)
    end

    def digest(path_hash, params_hash)
      Digest::MD5.hexdigest("#{path_hash}#{params_hash}")
    end
  end
end
