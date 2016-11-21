# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'nginxtop/version'

Gem::Specification.new do |spec|
  spec.name          = "nginxtop"
  spec.version       = NginxTop::VERSION
  spec.authors       = ["Ashish Bista"]
  spec.email         = ["b@ashishbista.com"]

  spec.summary       = %q{NGIN Top: NGINX Access Log Parser and Monitoring Tool.}
  spec.description   = %q{Parse and monitor NGINX incoming requests based on its access log.}
  spec.homepage      = "https://github.com/ashishbista/nginxtop"
  spec.license       = "MIT"
  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry", "~> 0.10.4"
end
