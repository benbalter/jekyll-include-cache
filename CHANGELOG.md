# Changelog

## 0.3.1

Maintenance release: no runtime behavior changes.

### Documentation

- Add a gemspec description and RubyGems metadata (homepage, source code,
  bug tracker, and changelog links), and lead the README with the same
  one-line description (#46)

## 0.3.0

### Bug fixes

- Name the Jekyll 4 cache `JekyllIncludeCache` instead of `Module`, and clear
  the digest cache on each rebuild so `jekyll serve` no longer grows without
  bound (#43)

### Performance

- Keep rendered includes in memory instead of writing each one to
  `.jekyll-cache` and wiping it before every render. Rebuilds were about 27%
  faster in a 1,000-page benchmark with identical output (#43)

### Dependencies

- Declare `required_ruby_version >= 3.0` (#32)

### Infrastructure

- Bump `github/codeql-action` (#33, #37, #41, #42, #44)

## 0.2.2

Maintenance release: no runtime behavior changes.

### Infrastructure

- Modernize CI — test Ruby 3.3 & 4.0 against Jekyll 3.x & 4.x, and fix the
  build under rubocop-rspec 3.0 (#30)
- Bump rubocop-rspec to `~> 3.0` (#25)
- Enable Dependabot for GitHub Actions; bump `actions/checkout` and
  `github/codeql-action` (#27, #28, #29)
- Add CodeQL analysis workflow

### Misc

- Fix a spelling mistake (#24)
