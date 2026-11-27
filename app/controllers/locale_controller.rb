class LocaleController < ApplicationController
  def switch
    locale = params[:id].to_s.to_sym
    cookies[:locale] = locale if I18n.available_locales.include?(locale)
    redirect_to request.referrer || root_path
  end
end
