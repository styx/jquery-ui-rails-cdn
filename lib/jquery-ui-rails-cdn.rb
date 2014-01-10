require 'jquery-ui-rails'
require 'jquery-rails-cdn/version'

module Jquery::Ui::Rails::Cdn
  module ActionViewExtensions
    JQUERY_UI_VERSION = Jquery::Ui::Rails::JQUERY_UI_VERSION
    OFFLINE = (Rails.env.development? or Rails.env.test?)

    JS_URL = {
      :google     => "//ajax.googleapis.com/ajax/libs/jqueryui/#{JQUERY_UI_VERSION}/jquery-ui.min.js",
      :microsoft  => "//ajax.aspnetcdn.com/ajax/jquery.ui/#{JQUERY_UI_VERSION}/jquery-ui.min.js",
      :jquery     => "http://code.jquery.com/ui/#{JQUERY_UI_VERSION}/jquery-ui.min.js",
      :yandex     => "//yandex.st/jquery-ui/#{JQUERY_UI_VERSION}/jquery-ui.min.js",
      :cloudflare => "//cdnjs.cloudflare.com/ajax/libs/jqueryui/#{JQUERY_UI_VERSION}/jquery-ui.min.js"
    }

    def jquery_ui_javascript_url(name, options = {})
      return JS_URL[name]
    end

    def jquery_ui_javascript_tag(name, options = {})
      return javascript_include_tag(:'jquery.ui.all') if OFFLINE and !options[:force]

      [ javascript_include_tag(jquery_ui_javascript_url(name, options)),
        javascript_tag("window.jQuery.ui || document.write(unescape('#{javascript_include_tag(:'jquery.ui.all').gsub('<','%3C')}'))")
      ].join("\n").html_safe
    end

    alias_method :jquery_ui_url, :jquery_ui_javascript_url
    alias_method :jquery_ui_include_tag, :jquery_ui_javascript_tag

  end

  class Railtie < Rails::Railtie
    initializer 'jquery_ui_rails_cdn.action_view' do |app|
      ActiveSupport.on_load(:action_view) do
        include Jquery::Ui::Rails::Cdn::ActionViewExtensions
      end
    end
  end
end
