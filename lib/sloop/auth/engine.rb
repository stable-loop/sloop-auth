# frozen_string_literal: true

require "rails/engine"

module Sloop
  module Auth
    class Engine < ::Rails::Engine
      initializer "sloop_auth.load_locales" do |app|
        app.config.i18n.load_path += Dir[Sloop::Auth::Engine.root.join("config/locales/**/*.yml")]
      end

      config.to_prepare do
        ::ApplicationController
        require Devise::Engine.root.join("app/controllers/devise_controller").to_s
        ::DeviseController.prepend_view_path Sloop::Auth::Engine.root.join("app/views")
      end
    end
  end
end
