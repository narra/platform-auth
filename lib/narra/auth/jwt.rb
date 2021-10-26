# Copyright: (c) 2021, Michal Mocnak <michal@narra.eu>, Eric Rosenzveig <eric@narra.eu>
# Copyright: (c) 2021, Narra Project
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)

require 'narra/tools'

module Narra
  module Auth
    module JWT
      RSA_PRIVATE = OpenSSL::PKey::RSA.new(Narra::Tools::Settings.rsa_private_pem)
      RSA_PUBLIC = OpenSSL::PKey::RSA.new(Narra::Tools::Settings.rsa_public_pem)
    end
  end
end
