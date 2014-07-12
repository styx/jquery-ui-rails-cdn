# jquery-ui-rails-cdn

NOTE: use v0.1.5 to use jquery-ui less then 5.0

Add CDN support to

* [jquery-ui-rails](https://github.com/joliss/jquery-ui-rails).

This gem is designed to be used with [jquery-rails-cdn](https://github.com/kenn/jquery-rails-cdn)

Serving javascripts and stylesheets from a publicly available [CDN](http://en.wikipedia.org/wiki/Content_Delivery_Network) has clear benefits:

* **Speed**: Users will be able to download jQuery UI from the closest physical location.
* **Caching**: CDN is used so widely that potentially your users may not need to download jQuery UI and others at all.
* **Parallelism**: Browsers have a limitation on how many connections can be made to a single host. Using CDN for jQuery UI offloads a big one.

## Features

This gem offers the following features:

* Supports multiple CDN. (Google, Microsoft, Yandex and jqueryui.com)
* jQuery-UI version is automatically detected via jquery-ui-rails.
* Automatically fallback to jquery-ui-rails' bundled jQuery UI when:
  * You're on a development environment so that you can work offline.
  * The CDN is down or unavailable.

On top of that, if you're using asset pipeline, you may have noticed that the major chunks of the code in `application.js` is jQuery UI. Implications of externalizing jQuery UI from `application.js` are:

* Updating your js code won't evict the entire cache in browsers - your code changes more often than jQuery UI upgrades, right?
* `rake assets:precompile` takes less peak memory usage.

Changelog:

* v0.1.5: Lock jquery-ui-rails to < 5.0 due to major changes in jquery-ui
* v0.1.4: Stop exposing ```force: true``` to the tag
* v0.1.3: Various bugfixes
* v0.1.2: Compatibility fix + various gem spec changes
* v0.1.1: Readme fix
* v0.1.0: Initial release

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'jquery-ui-rails-cdn'
```

### WARNING

From `jquery-ui-rails` `4.1.0` onward, `Jquery::Ui::Rails::JQUERY_UI_VERSION` is defiend and auto updated on each release.
* [See this commit](https://github.com/joliss/jquery-ui-rails/commit/e22a185)

If you are using version lower than `4.1.0`, you will need to use forked version of jquery-ui-rails
* [techbang-jquery-ui-rails](https://github.com/techbang/jquery-ui-rails)
or any other which defines `Jquery::Ui::Rails::JQUERY_UI_VERSION`.

## Usage

This gem adds these methods to generate a script tag to the jQuery on a CDN of your preference:
`jQuery_ui_include_tag` and `jquery_ui_url`

If you're using asset pipeline with Rails 3.1+, first remove `//= require jquery-ui` (or other special files if you are using not full version) from `application.js`.

Then in layout:

```ruby
= jquery_include_tag :google
= jquery_ui_include_tag :google
= javascript_include_tag 'application'
```

Note that valid CDN symbols for jQuery and jQuery-UI are:

```ruby
:google
:microsoft
:jquery
:yandex
```

Note that valid CDN symbols for bootstrap are:

```ruby
:default
```

It will generate the following for jQuery-UI on production:

```html
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.8.4/jquery.min.js" type="text/javascript"></script>
<script type="text/javascript">
//<![CDATA[
window.jQuery || document.write(unescape('%3Cscript src="/assets/jquery-ui-3aaa3fa0b0207a1abcd30555987cd4cc.js" type="text/javascript">%3C/script>'))
//]]>
</script>
```

on development:

```html
<script src="/assets/jquery.js?body=1" type="text/javascript"></script>
```

If you want to check the production URL, you can pass `:force => true` as an option.

```ruby
jquery_ui_include_tag :google, :force => true
```

To fallback to rails assets when CDN is not available, add `jquery-ui.js` in `config/environments/production.rb`

```ruby
config.assets.precompile += %w( jquery.js jquery-ui.js )
```
