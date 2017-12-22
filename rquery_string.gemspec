Gem::Specification.new do |s|
  s.name        = 'rquery_string'
  s.version     = '0.0.1'
  s.date        = '2013-07-11'
  s.summary     = "query string generator and parser"
  s.description = "query string generator and parser gem"
  s.authors     = ["Grant Chen"]
  s.email       = 'grantcss1982@gmail.com'
  s.license     = 'MIT'

  s.files         = Dir['lib/**/*.rb'] + Dir['*.rb']
  s.homepage    =
    'https://github.com/grantchen/rquery_string'

  s.add_development_dependency 'rspec', '~> 2.14.1'
end
