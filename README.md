# Jekyll Google Tag Manager Plugin

A [Jekyll][jekyll] plugin to insert [Google Tag Manager][gtm] tags into the head and body of your site.

[![GitHub Workflow Status](https://img.shields.io/github/workflow/status/t-richards/jekyll-google-tag-manager/Test?style=flat-square)](https://github.com/t-richards/jekyll-google-tag-manager/actions)
[![Gem Version](https://img.shields.io/gem/v/jekyll-google-tag-manager.svg?style=flat-square)](https://rubygems.org/gems/jekyll-google-tag-manager)
[![Code Coverage](https://img.shields.io/codecov/c/github/t-richards/jekyll-google-tag-manager.svg?style=flat-square)](https://codecov.io/gh/t-richards/jekyll-google-tag-manager)

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

You must specify a single GTM container in your site's `_config.yml`. You can
optionally include a transport URL if you are using a server side container.

```yaml
google:
  tag_manager:
    container_id: GTM-NNNNNNN
    transport_url: https://blah.com
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
[jekyll]: https://jekyllrb.com/
