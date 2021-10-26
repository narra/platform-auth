# Copyright: (c) 2021, Michal Mocnak <michal@narra.eu>, Eric Rosenzveig <eric@narra.eu>
# Copyright: (c) 2021, Narra Project
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)

module Narra
  module Auth
    module Providers
      class Developer < Narra::SPI::Auth

        @identifier = :developer
        @name = 'Developer Auth Provider'
        @description = 'Developer Auth Provider for development environment'
        @requirements = []

        def self.valid?
          Rails.env.development?
        end
      end
    end
  end
end
