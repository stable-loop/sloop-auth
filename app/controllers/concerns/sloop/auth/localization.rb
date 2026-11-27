module Sloop
  module Auth
    module Localization
      extend ActiveSupport::Concern

      included do
        before_action :set_locale
      end

      private

      def set_locale
        locale = cookies[:locale].to_s.to_sym
        I18n.locale = I18n.available_locales.include?(locale) ? locale : I18n.default_locale
      end
    end
  end
end
