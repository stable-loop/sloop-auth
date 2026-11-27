# frozen_string_literal: true

require "rails/engine"
require_relative "../../../app/helpers/sloop/auth/application_helper"

module Sloop
  module Auth
    class Engine < ::Rails::Engine
      initializer "sloop_auth.importmap", before: "importmap" do |app|
        next unless app.config.respond_to?(:importmap)

        app.config.importmap.paths << root.join("config/importmap.rb")
        app.config.importmap.cache_sweepers << root.join("app/assets/javascripts")
      end

      initializer "sloop_auth.load_locales" do |app|
        app.config.i18n.load_path += Dir[Sloop::Auth::Engine.root.join("config/locales/**/*.yml")]
      end

      initializer "sloop_auth.helpers" do
        ActiveSupport.on_load(:action_controller) do
          helper Sloop::Auth::ApplicationHelper
        end
      end

      config.to_prepare do
        ::ApplicationController
        require Devise::Engine.root.join("app/controllers/devise_controller").to_s
        ::DeviseController.prepend_view_path Sloop::Auth::Engine.root.join("app/views")
      end
    end
  end
end
