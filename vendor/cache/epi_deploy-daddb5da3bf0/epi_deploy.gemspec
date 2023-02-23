# -*- encoding: utf-8 -*-
# stub: epi_deploy 2.1.1 ruby lib

Gem::Specification.new do |s|
  s.name = "epi_deploy".freeze
  s.version = "2.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Anthony Nettleship".freeze, "Shuo Chen".freeze, "Chris Hunt".freeze, "James Gregory".freeze]
  s.date = "2022-05-17"
  s.description = "A gem to facilitate deployment across multiple git branches and evironments".freeze
  s.email = ["anthony.nettleship@epigenesys.org.uk".freeze, "shuo.chen@epigenesys.org.uk".freeze, "chris.hunt@epigenesys.org.uk".freeze, "james.gregory@epigenesys.org.uk".freeze]
  s.executables = ["ed".freeze, "epi_deploy".freeze]
  s.files = [".github/workflows/ruby.yml".freeze, ".gitignore".freeze, "Capfile".freeze, "Gemfile".freeze, "LICENSE.txt".freeze, "README.md".freeze, "Rakefile".freeze, "bin/ed".freeze, "bin/epi_deploy".freeze, "config/deploy.rb".freeze, "config/deploy/demo.rb".freeze, "config/deploy/production.rb".freeze, "epi_deploy.gemspec".freeze, "lib/capistrano/epi_deploy.rb".freeze, "lib/capistrano/tasks/multi_customers.rb".freeze, "lib/epi_deploy.rb".freeze, "lib/epi_deploy/app_version.rb".freeze, "lib/epi_deploy/command.rb".freeze, "lib/epi_deploy/git_wrapper.rb".freeze, "lib/epi_deploy/helpers.rb".freeze, "lib/epi_deploy/release.rb".freeze, "lib/epi_deploy/setup.rb".freeze, "lib/epi_deploy/stages_extractor.rb".freeze, "lib/epi_deploy/version.rb".freeze, "spec/features/deploy_spec.rb".freeze, "spec/features/release_spec.rb".freeze, "spec/fixtures/config/deploy/demo.rb".freeze, "spec/fixtures/config/deploy/production.epigenesys.rb".freeze, "spec/fixtures/config/deploy/production.genesys.rb".freeze, "spec/lib/epi_deploy/command_spec.rb".freeze, "spec/lib/epi_deploy/git_wrapper_spec.rb".freeze, "spec/lib/epi_deploy/release_spec.rb".freeze, "spec/lib/epi_deploy/stages_extractor_spec.rb".freeze, "spec/spec_helper.rb".freeze, "spec/support/aruba_helper.rb".freeze]
  s.homepage = "https://www.epigenesys.org.uk".freeze
  s.rubygems_version = "3.1.6".freeze
  s.summary = "eD".freeze
  s.test_files = ["spec/features/deploy_spec.rb".freeze, "spec/features/release_spec.rb".freeze, "spec/fixtures/config/deploy/demo.rb".freeze, "spec/fixtures/config/deploy/production.epigenesys.rb".freeze, "spec/fixtures/config/deploy/production.genesys.rb".freeze, "spec/lib/epi_deploy/command_spec.rb".freeze, "spec/lib/epi_deploy/git_wrapper_spec.rb".freeze, "spec/lib/epi_deploy/release_spec.rb".freeze, "spec/lib/epi_deploy/stages_extractor_spec.rb".freeze, "spec/spec_helper.rb".freeze, "spec/support/aruba_helper.rb".freeze]

  s.installed_by_version = "3.1.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<slop>.freeze, ["~> 3.6"])
    s.add_runtime_dependency(%q<git>.freeze, ["~> 1.5"])
  else
    s.add_dependency(%q<slop>.freeze, ["~> 3.6"])
    s.add_dependency(%q<git>.freeze, ["~> 1.5"])
  end
end
