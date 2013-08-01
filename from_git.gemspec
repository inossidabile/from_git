# coding: utf-8
Gem::Specification.new do |s|

  s.name          = "from_git"
  s.description   = %q{Allows you to install gem from git repository"}
  s.summary       = s.description
  s.authors       = ["Boris Staal"]
  s.email         = "boris@staal.io"
  s.homepage      = "http://github.com/inossidabile/from_git"
  s.version       = "0.1.0"
  s.license       = "MIT"

  s.files         = `git ls-files`.split($/)
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ["lib"]

  s.add_dependency "colored"
  s.add_development_dependency "bundler", "~> 1.3"
  s.add_development_dependency "rake"
end