# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cocoapods-xcframework/gem_version.rb'

Gem::Specification.new do |spec|
  spec.name          = 'cocoapods-bb-xcframework'
  spec.version       = CocoapodsXCFramework::VERSION
  spec.authors       = ['humin']
  spec.email         = ['humin1102@126.com']
  spec.description   = %q{把podspec打包成xcframework的小工具。packager pod to a xcframework}
  spec.summary       = %q{把podspec打包成xcframework的小工具。packager pod to a xcframework}
  spec.homepage      = 'https://github.com/humin1102/cocoapods-bb-xcframework'
  spec.license       = 'MIT'

  spec.files = Dir["lib/**/*.rb","spec/**/*.rb","lib/**/*.plist"] + %w{README.md LICENSE.txt }
  # spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']
  spec.add_dependency "cocoapods", '>= 1.10.0', '< 2.0'

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
end
