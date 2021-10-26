# Copyright: (c) 2021, Michal Mocnak <michal@narra.eu>, Eric Rosenzveig <eric@narra.eu>
# Copyright: (c) 2021, Narra Project
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)

require 'jwt'

module Narra
  module Auth
    module Constraints
      class AdminConstraint

        def self.matches?(request)
          # check for token presence
          return false if request.params[:token].nil? && request.session[:token].nil?

          begin
            # set token to session
            request.session[:token] = request.params[:token] unless request.params[:token].nil?

            # decode token
            decoded_token = ::JWT.decode request.session[:token], Narra::Auth::JWT::RSA_PUBLIC, true, { :algorithm => 'RS256' }

            # get uid
            uid = decoded_token[0]['uid']

            # get identity for token
            identity = Narra::Auth::Identity.where(uid: uid).first

            # signout in case non existing identity
            raise if identity.nil?

            # get user from token
            return identity.user.is?([:admin])
          rescue
            return false
          end
        end
      end
    end
  end
end
