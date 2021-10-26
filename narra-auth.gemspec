# Copyright: (c) 2021, Michal Mocnak <michal@narra.eu>, Eric Rosenzveig <eric@narra.eu>
# Copyright: (c) 2021, Narra Project
# GNU General Public License v3.0+ (see COPYING or https://www.gnu.org/licenses/gpl-3.0.txt)

require_relative "lib/narra/auth/version"

Gem::Specification.new do |spec|
  spec.name        = "narra-auth"
  spec.version     = Narra::Auth::VERSION
  spec.authors     = ["Michal Mocnak", "Eric Rosenzveig"]
  spec.email       = ["michal@narra.eu", "eric@narra.eu"]

  spec.summary     = "Write a short summary, because RubyGems requires one."
  spec.description = "Write a longer description or delete this line."
  spec.homepage    = "https://github.com/narra"
  spec.license     = "gpl-3.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/narra/platform-auth"
  spec.metadata["narra"] = "module"

  spec.files = Dir["{app,config,db,lib}/**/*", "COPYING", "Rakefile", "README.md"]

  spec.add_dependency "rails", "~> 6.1.3"
  spec.add_dependency "mongoid", "~> 7.2.1"
  spec.add_dependency "grape", "~> 1.5.3"
  spec.add_dependency "wisper", "~> 2.0.0"
  spec.add_dependency "omniauth", "~> 2.0.3"
  spec.add_dependency "jwt", "~> 2.2.2"
end
