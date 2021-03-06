
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "minicap/version"

Gem::Specification.new do |spec|
  spec.name          = "minicap-ruby"
  spec.version       = Minicap::VERSION
  spec.authors       = ["Hiroshi Saito"]
  spec.email         = ["saito.die@gmail.com"]

  spec.summary       = %q{Ruby interface for fetching Android real-time screen capture data via minicap.}
  spec.homepage      = "https://github.com/saidie/minicap-ruby"
  spec.license       = "MIT"

  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.17"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
end
