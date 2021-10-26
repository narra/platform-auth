# Copyright: (c) 2021, Michal Mocnak <michal@narra.eu>, Eric Rosenzveig <eric@narra.eu>
# Copyright: (c) 2021, Narra Project
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)

module Narra
  module Auth
    class Identity
      include Mongoid::Document
      include Mongoid::Timestamps

      # Fields
      field :provider, type: String
      field :uid, type: String

      # User relations
      belongs_to :user, class_name: 'Narra::Auth::User'

      # Validations
      validates_uniqueness_of :uid, scope: :provider
      validates_presence_of :user_id, :uid, :provider

      # Find identity from the omniauth hash
      def self.find_from_hash(hash)
        Narra::Auth::Identity.where(provider: hash[:provider], uid: hash[:uid]).first
      end

      # Create a new identity from the omniauth hash
      def self.create_from_hash(hash, user = nil)
        user ||= Narra::Auth::User.create_from_hash!(hash)
        Narra::Auth::Identity.create(user: user, uid: hash[:uid], provider: hash[:provider])
      end
    end
  end
end
