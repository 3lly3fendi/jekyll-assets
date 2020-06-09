# Frozen-string-literal: true
# Copyright: 2012 - 2020 - ISC License
# Author: Jordon Bedwell
# Encoding: utf-8

module Jekyll
  module Assets
    class Default
      class CSS < Default
        content_types "text/css"
        static rel: "stylesheet"
        internal!

        # --
        def set_type
          return if args.key?(:type) || !config[:type]
          args[:type] = "text/css"
        end

        def set_href_if_url
          return if args[:inline] || !asset.is_a?(Url)
          args.update(
            href: asset.url
          )
        end

        def set_href
          return if args[:inline] || asset.is_a?(Url)
          args[:href] = env.prefix_url(
            asset.digest_path
          )
        end

        def set_integrity
          return unless integrity?
          args[:integrity] = asset.integrity
          if !args.key?(:crossorigin) && args[:integrity]
            args.update(
              crossorigin: 'anonymous'
            )
          end
        end

        def integrity?
          config[:integrity] && !asset.is_a?(Url) &&
            !args.key?(
              :integrity
            )
        end
      end
    end
  end
end

# --
Jekyll::Assets::Hook.register :config, :before_merge do |c|
  c.deep_merge!({
    defaults: {
      css: {
        integrity: Jekyll.production?,
        type: true,
      },
    },
  })
end
