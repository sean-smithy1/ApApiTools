
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "ap_api_tools/version"

Gem::Specification.new do |spec|
  spec.name          = "ApApiTools"
  spec.version       = ApApiTools::VERSION
  spec.authors       = ["Sean Smith"]
  spec.email         = ["sean.smith@comapps.net"]

  spec.summary       = %q{API Tools for Artists Place}
  spec.description   = %q{Various Tools to interact with AP from a console. Bulk upload, Image downloads}
  spec.homepage      = "https://www.artistsplace.com.au"
  spec.license       = "MIT"

  spec.add_runtime_dependency 'json', '~> 1.8', '>= 1.8.3'
  spec.add_runtime_dependency 'http'
  
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
  spec.add_development_dependency "rspec", "~> 3.0"
end
