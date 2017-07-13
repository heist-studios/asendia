Gem::Specification.new do |spec|
  spec.name        = 'asendia'
  spec.version     = '0.0.1'
  spec.date        = '2017-07-13'
  spec.summary     = 'Asendia API client'
  spec.authors     = ['James McCarthy', 'Tim Davies']
  spec.email       = ['james@heist-studios.com', 'tim@heist-studios.com']
  spec.files       = ['lib/asendia.rb']
  spec.homepage    = 'https://github.com/heist-studios/asendia'
  # spec.license     = 'MIT'

  # Runtime dependencies:
  spec.add_runtime_dependency 'savon',  '~> 2.11.0'
  spec.add_runtime_dependency 'virtus', '~> 1.0.5'
end
