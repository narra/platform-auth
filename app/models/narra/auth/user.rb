# Copyright: (c) 2021, Michal Mocnak <michal@narra.eu>, Eric Rosenzveig <eric@narra.eu>
# Copyright: (c) 2021, Narra Project
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)

require 'wisper'

module Narra
  module Auth
    class User
      include Mongoid::Document
      include Mongoid::Timestamps
      include Wisper::Publisher

      # Fields
      field :name, type: String
      field :email, type: String
      field :image, type: String
      field :roles, type: Array, default: []

      # Identity Relations
      has_many :identities, dependent: :destroy, class_name: 'Narra::Auth::Identity'

      # Validations
      validates_uniqueness_of :email

      # Hooks
      after_create :broadcast_events

      # Check if the user has certain role
      def is?(roles_check = [])
        !(roles & roles_check).empty?
      end

      # Get all roles registered in the system
      def self.all_roles
        Narra::Auth::User.only(:roles).map(&:roles).reduce(:+).uniq
      end

      # Create a new user from the omniauth hash
      def self.create_from_hash!(hash)
        # create new user
        user = Narra::Auth::User.new(name: hash[:name], email: hash[:email], image: hash[:image])

        # assign default roles
        user.roles = (Narra::Auth::User.empty?) ? [:admin, :author] : [:author]

        # save
        return (user.save) ? user : nil
      end

      protected

      def broadcast_events
        broadcast(:narra_user_admin_created, { email: self.email }) if Narra::Auth::User.count == 1
      end
    end
  end
end
