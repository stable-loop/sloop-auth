# frozen_string_literal: true

module Sloop
  module Auth
    module ApplicationHelper
      def dark_mode? = cookies[:dark_mode] == "true"
      def nav_logo_by_mode = dark_mode? ? "nav_dark.png" : "nav_light.png"
      def yield_or_default(name)
        content_for?(name) ? Nokogiri::HTML(content_for(name)).text : t(name)
      end
      def time_version = Time.zone.now.strftime("%Y.%m.%d.%H%M.%S")
    end
  end
end
