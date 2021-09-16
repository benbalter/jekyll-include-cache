# Jekyll Include Cache

*A Jekyll plugin to cache the rendering of Liquid includes*

[![CI](https://github.com/benbalter/jekyll-include-cache/actions/workflows/ci.yml/badge.svg)](https://github.com/benbalter/jekyll-include-cache/actions/workflows/ci.yml)

## What it does

If you have a computationally expensive include (such as a sidebar or navigation), Jekyll Include Cache renders the include once, and then reuses the output any time that includes is called with the same arguments, potentially speeding up your site's build significantly.

## Usage

1. Add the following to your site's Gemfile:

  ```ruby
  gem 'jekyll-include-cache'
  ```

2. Add the following to your site's config file:

  ```yml
  plugins:
    - jekyll-include-cache
  ```
  💡 If you are using a Jekyll version less than 3.5.0, use the `gems` key instead of `plugins`.

3. Replace `{% include foo.html %}` in your template with `{% include_cached foo.html %}`

## One potential gotcha

For Jekyll Include Cache to work, you cannot rely on the page context to pass variables to your include (e.g., `assign foo=bar` or `page.title`). Instead, you must explicitly pass all variables to the include as arguments, and reference them within the include as `include.foo` (instead of `page.foo` or just `foo`).

### Good

In your template:

```liquid
{% include_cached shirt.html size=medium color=red %}
```

In your include:

```liquid
Buy our {{ include.color }} shirt in {{ include.size }}!
```

### Bad

In your template:

```liquid
{% assign color=blue %}
{% include_cached shirt.html %}
```

In your include:

```liquid
Buy our {{ color }} shirt in {{ page.size }}!
```
