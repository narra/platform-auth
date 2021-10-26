# Copyright: (c) 2021, Michal Mocnak <michal@narra.eu>, Eric Rosenzveig <eric@narra.eu>
# Copyright: (c) 2021, Narra Project
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)

require 'omniauth'
require 'wisper'

require "narra/spi"

require_relative 'auth/version'
require_relative 'auth/logger'
require_relative 'auth/engine'
require_relative 'auth/providers'
require_relative 'auth/listeners'
require_relative 'auth/constraints'

module Narra
  module Auth
    # main container
    PROVIDERS ||= []

    # overriding CVE-2015-9284
    # TODO: remove GET requests to OmniAuth accross narra
    OmniAuth.config.allowed_request_methods = [:post, :get]
    OmniAuth.config.silence_get_warning = true
  end
end
