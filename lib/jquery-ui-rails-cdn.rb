require 'jquery-ui-rails'
require 'jquery-rails-cdn/version'

module Jquery::Ui::Rails::Cdn
  module ActionViewExtensions
    JQUERY_UI_VERSION = Jquery::Ui::Rails::JQUERY_UI_VERSION
    OFFLINE = (Rails.env.development? or Rails.env.test?)

    URL = {
      :google     => "//ajax.googleapis.com/ajax/libs/jqueryui/#{JQUERY_UI_VERSION}/jquery-ui.min.js",
      :microsoft  => "//ajax.aspnetcdn.com/ajax/jquery.ui/#{JQUERY_UI_VERSION}/jquery-ui.min.js",
      :jquery     => "http://code.jquery.com/ui/#{JQUERY_UI_VERSION}/jquery-ui.min.js",
      :yandex     => "//yandex.st/jquery-ui/#{JQUERY_UI_VERSION}/jquery-ui.min.js"
    }

    def jquery_ui_url(name, options = {})
      return URL[name]
    end

    def jquery_ui_include_tag(name, options = {})
      return javascript_include_tag(:'jquery-ui') if OFFLINE and !options[:force]

      [ javascript_include_tag(jquery_ui_url(name, options)),
        javascript_tag("window.jQuery.ui || document.write(unescape('#{javascript_include_tag(:'jquery-ui').gsub('<','%3C')}'))")
      ].join("\n").html_safe
    end
  end

  class Railtie < Rails::Railtie
    initializer 'jquery_ui_rails_cdn.action_view' do |app|
      ActiveSupport.on_load(:action_view) do
        include Jquery::Ui::Rails::Cdn::ActionViewExtensions
      end
    end
  end
end
