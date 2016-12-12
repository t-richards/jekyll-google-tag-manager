# Jekyll Google Tag Manager Plugin

A Jekyll plugin to insert [Google Tag Manager][gtm] tags into the head and body of your site.

[![Travis](https://img.shields.io/travis/t-richards/jekyll-google-tag-manager.svg)](https://travis-ci.org/t-richards/jekyll-google-tag-manager)
[![Gem](https://img.shields.io/gem/v/jekyll-google-tag-manager.svg)](https://rubygems.org/gems/jekyll-google-tag-manager)

## Installation

Add the plugin to your site's Gemfile:

```ruby
group :jekyll_plugins do
  gem 'jekyll-google-tag-manager'
end
```

And then execute:

```bash
$ bundle install
```

## Usage

You must specify a single GTM container in your site's `_config.yml`.

```yaml
google:
  tag_manager:
    container_id: GTM-NNNNNNN
```

Add the following right after the opening of the `<head>` tag in your site template(s):

```liquid
{% gtm head %}
```

Add the following right after the opening of the `<body>` tag in your site template(s):

```liquid
{% gtm body %}
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/t-richards/jekyll-google-tag-manager.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

[gtm]: https://www.google.com/analytics/tag-manager/
