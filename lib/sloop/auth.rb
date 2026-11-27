# frozen_string_literal: true

require_relative "auth/version"
require_relative "auth/engine"
require "devise"
require "haml-rails"
require "omniauth-google-oauth2"
require "omniauth/rails_csrf_protection"

module Sloop
  module Auth
  end
end
