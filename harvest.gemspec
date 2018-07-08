
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "harvest/version"

Gem::Specification.new do |spec|
  spec.name          = "harvest"
  spec.version       = Harvest::VERSION
  spec.authors       = ["Guillermo Iguaran"]
  spec.email         = ["guilleiguaran@gmail.com"]

  spec.summary       = %q{Harvest v2 API library for Ruby.}
  spec.description   = %q{Harvest v2 API library for Ruby.}
  spec.homepage      = "https://github.com/ableco"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_dependency "her", ">= 0.10"
  spec.add_dependency "activemodel", "~> 5.1.6"
  spec.add_dependency "faraday_middleware", ">= 0.12"
  spec.add_dependency "net-http-persistent", ">= 3.0.0"
end
