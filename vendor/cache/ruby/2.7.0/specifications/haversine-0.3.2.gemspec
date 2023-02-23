# -*- encoding: utf-8 -*-
# stub: haversine 0.3.2 ruby lib

Gem::Specification.new do |s|
  s.name = "haversine".freeze
  s.version = "0.3.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Kristian Mandrup".freeze, "Ryan Greenberg".freeze]
  s.date = "2016-10-04"
  s.description = "Calculates the haversine distance between two locations using longitude and latitude. \nThis is done using Math formulas without resorting to Active Record or SQL DB functionality".freeze
  s.email = "kmandrup@gmail.com".freeze
  s.extra_rdoc_files = ["LICENSE.txt".freeze, "README.textile".freeze]
  s.files = ["LICENSE.txt".freeze, "README.textile".freeze]
  s.homepage = "http://github.com/kristianmandrup/haversine".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.1.6".freeze
  s.summary = "Calculates the haversine distance between two locations using longitude and latitude".freeze

  s.installed_by_version = "3.1.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_development_dependency(%q<rspec>.freeze, [">= 2.14.0"])
    s.add_development_dependency(%q<bundler>.freeze, [">= 1.3.0"])
    s.add_development_dependency(%q<jeweler>.freeze, [">= 1.8.6"])
  else
    s.add_dependency(%q<rspec>.freeze, [">= 2.14.0"])
    s.add_dependency(%q<bundler>.freeze, [">= 1.3.0"])
    s.add_dependency(%q<jeweler>.freeze, [">= 1.8.6"])
  end
end
