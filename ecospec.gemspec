# frozen_string_literal: true

require_relative "lib/ecospec/version"

Gem::Specification.new do |spec|
  spec.name = "ecospec"
  spec.version = Ecospec::VERSION
  spec.authors = ["Russell Jennings"]
  spec.email = ["russell@wrapbook.com"]

  spec.summary = "Economically run specs against git diff of changes"
  spec.description = "Economically run specs against git diff of changes"
  spec.homepage = "http://google.com"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.5.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = ["ecospec"]
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
