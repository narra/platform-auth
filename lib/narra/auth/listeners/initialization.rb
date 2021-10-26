# Copyright: (c) 2021, Michal Mocnak <michal@narra.eu>, Eric Rosenzveig <eric@narra.eu>
# Copyright: (c) 2021, Narra Project
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)

module Narra
  module Auth
    module Listeners
      class Initialization < Narra::SPI::Listener

        # default values
        @identifier = :auth
        @name = 'Authentication Initializer'
        @description = 'System Authentication Initializer'
        # register events
        @events = [:narra_system_initialized]

        # callbacks
        def narra_system_initialized(options)
          # set up jwt
          require "narra/auth/jwt"
          # register auth providers
          Narra::SPI::Auth.descendants.each do |auth|
            # validation
            if auth.valid?
              # register auth provider
              Rails.application.middleware.use OmniAuth::Builder do
                provider auth.identifier, :setup => auth
              end
              # add into the container
              PROVIDERS << auth.identifier
              # log action
              Narra::Auth::LOGGER.log_info("#{auth} provider registered", 'auth')
            end
          end
        end
      end
    end
  end
end
