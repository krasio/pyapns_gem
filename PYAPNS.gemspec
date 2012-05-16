# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "pyapns/version"

Gem::Specification.new do |s|
  s.name        = "pyapns"
  s.version     = PYAPNS::VERSION
  s.authors     = ["Samuel Sutch"]
  s.email       = ["krasio@codingspree.net"]
  s.homepage    = "https://github.com/krasio/pyapns_gem"
  s.summary     = %q{pyapns is an universal Apple Push Notification Service (APNS) provider. This is the ruby client.}
  s.description = %q{pyapns is an universal Apple Push Notification Service (APNS) provider. This is the ruby client.}


  s.rubyforge_project = "pyapns"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "ruby-debug"
  s.add_development_dependency "rspec"
end
